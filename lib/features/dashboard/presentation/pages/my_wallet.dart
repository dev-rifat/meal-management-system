import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:mass_management/core/widgets/custom_onloading.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/wallet_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/wallet_state.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';
import 'transaction_history.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<WalletCubit>()..load(),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "My Wallet",
        backgroundColor: AppColor.backgroundColor,
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state is WalletError) {
            return Center(child: Text(state.message));
          }
          if (state is! WalletLoaded) {
            return LoadingHelper.defaultLoading();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _walletSummaryCard(state.summary),
                const SizedBox(height: 20),
                Text(
                  "My Transactions",
                  style: AppStyle.titleText,
                ),
                const SizedBox(height: 16),
                TransactionScreen(transactions: state.transactions),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Wallet Summary Card
  Widget _walletSummaryCard(BalanceSummary summary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Balance", style: TextStyle(color: Colors.white70, fontSize: 16)),
              Text("Total Meal", style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "৳ ${summary.balance!.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                summary.mealRate!.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.arrow_downward, "My Deposit", "৳ ${summary.deposit.toStringAsFixed(2)}"),
              _infoItem(Icons.arrow_upward, "My Expense", "৳ ${summary.expense.toStringAsFixed(2)}"),
            ],
          ),
        ],
      ),
    );
  }

  /// Info item (Deposit / Expense)
  Widget _infoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.green.withValues(alpha: 0.2),
          child: Icon(icon, size: 18, color: Colors.green),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
