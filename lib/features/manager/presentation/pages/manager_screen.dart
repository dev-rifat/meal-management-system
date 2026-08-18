import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart'
    show CustomAppBar;
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_state.dart';
import 'package:mass_management/features/manager/presentation/widgets/operations.dart';
import 'package:mass_management/features/manager/presentation/widgets/pie_chart.dart'
    show ChartData, SummaryChart;
import 'package:mass_management/features/manager/presentation/widgets/summary_card.dart';
import 'package:mass_management/core/theme/app_color.dart';

class MessManagerPage extends StatefulWidget {
  const MessManagerPage({super.key});

  @override
  State<MessManagerPage> createState() => _MessManagerPageState();
}

class _MessManagerPageState extends State<MessManagerPage> {
  @override
  void initState() {
    super.initState();
    context.read<ManagerSummaryCubit>().loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ManagerSummaryCubit, ManagerSummaryState>(
          builder: (context, state) {
            final summary = state.summary;
            return Column(
              children: [
                Row(
                  children: [
                    SummaryCard(
                      title: summary != null ? '${summary.membersCount}' : '-',
                      subtitle: 'Members',
                    ),
                    SummaryCard(
                      title: summary != null
                          ? _formatCurrency(summary.totalCost)
                          : '-',
                      subtitle: 'Total cost',
                    ),
                    SummaryCard(
                      title: summary != null
                          ? _formatCurrency(summary.balance)
                          : '-',
                      subtitle: 'Balance',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _summaryChart(summary),
                const SizedBox(height: 12),
                const OperationsSection(),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatCurrency(double value) => '৳${value.toStringAsFixed(2)}';

  Widget _summaryChart(ExpenseSummary? summary) {
    return SummaryChart(
      onClick: () {},
      data: [
        ChartData(
          label: 'Remaining',
          percentage: summary?.remainingPercentage ?? 0,
          color: Colors.green,
        ),
        ChartData(
          label: 'Shared Expense',
          percentage: summary?.sharedExpensePercentage ?? 0,
          color: Colors.orange,
        ),
        ChartData(
          label: 'Food Expense',
          percentage: summary?.foodExpensePercentage ?? 0,
          color: Colors.deepPurple,
        ),
      ],
    );
  }

  _appBar() => CustomAppBar(
    leadingWidth: 300,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Text(
        "Manager",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ),
    backgroundColor: AppColor.backgroundColor,
  );
}
