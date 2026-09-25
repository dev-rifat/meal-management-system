import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_onloading.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/monthly_summary_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/monthly_summary_state.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/core/theme/app_style.dart';

class MonthlySummary extends StatelessWidget {
  const MonthlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<MonthlySummaryCubit>()..load(),
      child: const _MonthlySummaryView(),
    );
  }
}

class _MonthlySummaryView extends StatelessWidget {
  const _MonthlySummaryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leadingWidth: 400,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(child: _buildSearchBar(context)),
          ],
        ),
        actions: [_buildFilterDropdown(context)],
      ),
      body: BlocBuilder<MonthlySummaryCubit, MonthlySummaryState>(
        builder: (context, state) {
          if (state is MonthlySummaryError) {
            return Center(child: Text(state.message));
          }
          if (state is! MonthlySummaryLoaded) {
            return LoadingHelper.defaultLoading();
          }

          final mealRate = state.summary.mealRate;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.filter == "Custom" && state.range != null)
                  _buildSelectedRange(state.range!),
                _buildSummaryCard(
                  state.summary.totalCost,
                  state.summary.totalMeal,
                  mealRate,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Mess Members",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildMemberList(state.filteredMembers, mealRate),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔹 Filter Dropdown
  Widget _buildFilterDropdown(BuildContext context) {
    return BlocBuilder<MonthlySummaryCubit, MonthlySummaryState>(
      // Only depends on `filter`; skip the transient MonthlySummaryLoading
      // emitted on every filter/search change so the dropdown doesn't
      // flicker back to "This Month" mid-fetch.
      buildWhen: (previous, current) {
        if (current is! MonthlySummaryLoaded) return false;
        if (previous is! MonthlySummaryLoaded) return true;
        return previous.filter != current.filter;
      },
      builder: (context, state) {
        final filter = state is MonthlySummaryLoaded
            ? state.filter
            : "This Month";
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButton<String>(
            value: filter,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: const [
              DropdownMenuItem(value: "This Month", child: Text("This Month")),
              DropdownMenuItem(value: "Last Month", child: Text("Last Month")),
              DropdownMenuItem(value: "Custom", child: Text("Custom")),
            ],
            onChanged: (value) async {
              if (value == null) return;
              final cubit = context.read<MonthlySummaryCubit>();
              if (value == "Custom") {
                await _pickMonthRange(context, cubit);
              } else {
                cubit.changeFilter(value);
              }
            },
          ),
        );
      },
    );
  }

  // 🔹 Month range picker
  Future<void> _pickMonthRange(
    BuildContext context,
    MonthlySummaryCubit cubit,
  ) async {
    final start = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (start == null) return;
    if (!context.mounted) return;

    final end = await showMonthPicker(
      context: context,
      initialDate: start,
      firstDate: start,
      lastDate: DateTime(2050),
    );
    if (end == null) return;

    cubit.changeFilter(
      "Custom",
      range: DateTimeRange(start: start, end: end),
    );
  }

  // 🔹 Selected Month Range Display
  Widget _buildSelectedRange(DateTimeRange range) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.date_range, color: Colors.teal),
          const SizedBox(width: 8),
          Text(
            "${DateFormat('MMMM yyyy').format(range.start)} → ${DateFormat('MMMM yyyy').format(range.end)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Summary Card
  Widget _buildSummaryCard(
    double totalCost,
    double totalMeal,
    double mealRate,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      color: AppColor.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _summaryItem("Total Cost", "৳${totalCost.toStringAsFixed(0)}"),
            Container(width: 1, height: 40, color: Colors.white),
            _summaryItem("Meal Rate", "৳${mealRate.toStringAsFixed(2)}"),
            Container(width: 1, height: 40, color: Colors.white),
            _summaryItem("Total Meals", totalMeal.toStringAsFixed(0)),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: AppStyle.normalText.copyWith(
            color: AppColor.alertBgColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppStyle.normalText.copyWith(
            color: AppColor.cardColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // 🔹 Search Bar
  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (query) => context.read<MonthlySummaryCubit>().search(query),
      decoration: InputDecoration(
        hintText: "Search member...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 🔹 Member List
  Widget _buildMemberList(List<MonthlySummaryEntry> members, double mealRate) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        final mealCost = member.totalMeal * mealRate;
        final due = member.paid - mealCost;
        return _buildMemberCard(member, mealCost, due);
      },
    );
  }

  // 🔹 Individual Member Card
  Widget _buildMemberCard(
    MonthlySummaryEntry member,
    double mealCost,
    double due,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      color: AppColor.disableColor.withValues(alpha: 0.5),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          member.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Meal: ${member.totalMeal.toStringAsFixed(1)}"),
            Text("Total Cost: ৳${member.totalCost.toStringAsFixed(0)}"),
            Text("Meal Cost: ৳${mealCost.toStringAsFixed(0)}"),
            Text(
              due >= 0
                  ? "Status: ✅ Paid (৳${due.toStringAsFixed(0)} extra)"
                  : "Status: ❌ Due (৳${due.abs().toStringAsFixed(0)})",
              style: TextStyle(
                color: due >= 0 ? AppColor.successColor : AppColor.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
