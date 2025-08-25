import 'package:flutter/material.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';
import '../../../core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'transaction_history.dart';

class WalletScreen extends StatelessWidget {
  final double balance = -4912.00;
  final double totalMeal = 2.50;
  final double myDeposit = 1618.00;
  final double myExpense = 1880.00;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title:  "My Wallet",
        backgroundColor: AppColor.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _walletSummaryCard(),
            const SizedBox(height: 20),
             Text(
              "My Transactions",
              style: AppStyle.titleText,
            ),
            const SizedBox(height: 16),
            TransactionScreen(),
          ],
        ),
      ),
    );
  }

  /// Wallet Summary Card
  Widget _walletSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              Text("Total Meal",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("৳ ${balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(totalMeal.toStringAsFixed(2),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.arrow_downward, "My Deposit", "৳ $myDeposit"),
              _infoItem(Icons.arrow_upward, "My Expense", "৳ $myExpense"),
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
          backgroundColor: Colors.green.withOpacity(0.2),
          child: Icon(icon, size: 18, color: Colors.green),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

