import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';
import 'package:mass_management/core/theme/app_style.dart';

/// Renders a list of [Transaction]s. Reused by both the dashboard screen's
/// "Transaction History" section and the wallet screen's "My Transactions"
/// section — both are fed by the same `GetTransactionsUseCase` via their
/// respective cubits, so this widget only ever needs to render, not fetch.
class TransactionScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // prevents scroll conflict
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(transaction.title, style: AppStyle.normalText),
            subtitle: Text(
              DateFormat('yyyy-MM-dd').format(transaction.date),
              style: AppStyle.normalText.copyWith(fontSize: 12),
            ),
            trailing: Text(
              "${transaction.amount.toStringAsFixed(2)} ৳",
              style: AppStyle.normalText,
            ),
          ),
        );
      },
    );
  }
}
