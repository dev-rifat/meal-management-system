import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:mass_management/utils/app_color.dart';

/// Switches between the mess-wide and personal [BalanceSummary] card.
/// Reads from the [DashboardCubit] provided higher up by DashboardScreen
/// so both cards come from the same in-memory data source instead of two
/// sets of hardcoded strings.
class BalanceCardSwitcher extends StatelessWidget {
  const BalanceCardSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is! DashboardLoaded) {
          return const SizedBox(height: 160);
        }

        final summary = state.selectedBalance;
        final isPrimary = state.selectedBalanceIndex == 0;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: _balanceCard(
            context,
            key: ValueKey(isPrimary ? 'primary' : 'personal'),
            summary: summary,
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor,
                      AppColor.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Colors.indigo, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
        );
      },
    );
  }

  Widget _balanceCard(
    BuildContext context, {
    required Key key,
    required BalanceSummary summary,
    required Gradient gradient,
  }) {
    final headline = summary.mealRate != null
        ? "Per meal - ${summary.mealRate!.toStringAsFixed(1)}"
        : "৳ ${summary.balance!.toStringAsFixed(2)}";

    return GestureDetector(
      onTap: () => context.read<DashboardCubit>().toggleBalanceCard(),
      child: Container(
        key: key,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      summary.label,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.swap_horiz, color: Colors.white),
                        onPressed: () => context.read<DashboardCubit>().toggleBalanceCard(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  headline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _balanceItem(
                      Icons.arrow_downward,
                      "Deposit",
                      "৳ ${summary.deposit.toStringAsFixed(2)}",
                    ),
                    _balanceItem(
                      Icons.arrow_upward,
                      "Expense",
                      "৳ ${summary.expense.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _balanceItem(IconData icon, String label, String amount) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
