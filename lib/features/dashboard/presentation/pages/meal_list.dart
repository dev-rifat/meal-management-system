import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_onloading.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/meal_list_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/meal_list_state.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';

class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<MealListCubit>()..load(),
      child: const _MealDetailsView(),
    );
  }
}

class _MealDetailsView extends StatelessWidget {
  const _MealDetailsView();

  static const List<MapEntry<String, MonthFilter>> _monthFilters = [
    MapEntry("This Month", MonthFilter.thisMonth),
    MapEntry("Last Month", MonthFilter.lastMonth),
    MapEntry("Custom", MonthFilter.custom),
  ];

  static const List<MealStatus?> _statusFilters = [
    null,
    MealStatus.pending,
    MealStatus.approved,
    MealStatus.rejected,
  ];

  String _statusLabel(MealStatus? status) => status?.label ?? "All";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 360;

    final double fontSizeTitle = isSmallScreen ? 12 : 14;
    final double fontSizeValue = isSmallScreen ? 14 : 16;
    final double iconSize = isSmallScreen ? 22 : 18;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "",
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        actions: [
          /// ✅ Date Dropdown Filter
          BlocBuilder<MealListCubit, MealListState>(
            builder: (context, state) {
              final monthFilter = state is MealListLoaded ? state.monthFilter : MonthFilter.thisMonth;
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButton<MonthFilter>(
                  value: monthFilter,
                  underline: const SizedBox(),
                  items: _monthFilters
                      .map((entry) => DropdownMenuItem(value: entry.value, child: Text(entry.key)))
                      .toList(),
                  onChanged: (value) async {
                    if (value == null) return;
                    final cubit = context.read<MealListCubit>();
                    if (value == MonthFilter.custom) {
                      final picked = await _pickDate(context);
                      if (picked == null) return;
                      cubit.changeMonthFilter(value, customDate: picked);
                    } else {
                      cubit.changeMonthFilter(value);
                    }
                  },
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          /// ✅ Horizontal Filter Bar (Status)
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<MealListCubit, MealListState>(
                builder: (context, state) {
                  final selected = state is MealListLoaded ? state.statusFilter : null;
                  return Row(
                    children: _statusFilters.map((status) {
                      final label = _statusLabel(status);
                      final isSelected = selected == status;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          showCheckmark: false,
                          elevation: 0,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          label: Text(label),
                          selected: isSelected,
                          onSelected: (_) => context.read<MealListCubit>().changeStatusFilter(status),
                          selectedColor: AppColor.primaryColor,
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),

          /// ✅ Filtered Meal Cards
          Expanded(
            child: BlocBuilder<MealListCubit, MealListState>(
              builder: (context, state) {
                if (state is MealListError) {
                  return Center(child: Text(state.message));
                }
                if (state is! MealListLoaded) {
                  return LoadingHelper.defaultLoading();
                }

                final meals = state.meals;
                return ListView.builder(
                  itemCount: meals.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return MealCard(
                      date: meal.date,
                      size: size,
                      iconSize: iconSize,
                      fontSizeTitle: fontSizeTitle,
                      fontSizeValue: fontSizeValue,
                      breakfast: meal.breakfast,
                      lunch: meal.lunch,
                      dinner: meal.dinner,
                      total: meal.total,
                      status: meal.status,
                      onStatusChange: (newStatus) {
                        context.read<MealListCubit>().updateStatus(meal.id, newStatus);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
  }
}

/// ✅ Meal Card Widget
class MealCard extends StatelessWidget {
  final DateTime date;
  final Size size;
  final double iconSize, fontSizeTitle, fontSizeValue;
  final double breakfast, lunch, dinner, total;
  final MealStatus status;
  final ValueChanged<MealStatus> onStatusChange;

  const MealCard({
    super.key,
    required this.date,
    required this.size,
    required this.iconSize,
    required this.fontSizeTitle,
    required this.fontSizeValue,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.total,
    required this.status,
    required this.onStatusChange,
  });

  Color _getStatusColor(MealStatus status) {
    switch (status) {
      case MealStatus.approved:
        return Colors.green;
      case MealStatus.rejected:
        return Colors.red;
      case MealStatus.pending:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.black54, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEE, MMM dd, yyyy').format(date),
                              style: AppStyle.normalText.copyWith(
                                color: AppColor.hintColor,
                                fontSize: fontSizeTitle - 1,
                              ),
                            ),
                          ],
                        ),
                        (status == MealStatus.pending)
                            ? PopupMenuButton<MealStatus>(
                                onSelected: onStatusChange,
                                itemBuilder: (context) => [
                                  const PopupMenuItem(value: MealStatus.approved, child: Text("Approve")),
                                  const PopupMenuItem(value: MealStatus.rejected, child: Text("Reject")),
                                ],
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        status.label,
                                        style: AppStyle.normalText.copyWith(
                                          color: _getStatusColor(status),
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizeTitle,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down, size: 20),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  status.label,
                                  style: AppStyle.normalText.copyWith(
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizeTitle,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MealItem("Breakfast", breakfast, Icons.free_breakfast, iconSize, fontSizeTitle, fontSizeValue),
                        MealItem("Lunch", lunch, Icons.lunch_dining, iconSize, fontSizeTitle, fontSizeValue),
                        MealItem("Dinner", dinner, Icons.dinner_dining, iconSize, fontSizeTitle, fontSizeValue),
                        MealItem("Total", total, Icons.summarize, iconSize, fontSizeTitle, fontSizeValue),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealItem extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final double iconSize, titleSize, valueSize;

  const MealItem(this.title, this.value, this.icon, this.iconSize, this.titleSize, this.valueSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: iconSize),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppStyle.normalText.copyWith(
            fontSize: titleSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(1),
          style: AppStyle.normalText.copyWith(
            fontSize: valueSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
