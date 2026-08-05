import 'package:flutter/material.dart';
import 'package:mass_management/utils/app_style.dart';

class TransactionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {"title": "Deposit", "date": "2025-07-29", "amount": "8.00 ৳"},
    {"title": "Shared Expense", "date": "2025-07-29", "amount": "100.00 ৳"},
    {"title": "Personal Expense", "date": "2025-07-29", "amount": "100.00 ৳"},
    {"title": "Food Cost", "date": "2025-07-29", "amount": "100.00 ৳"},
    {"title": "Deposit", "date": "2025-07-29", "amount": "600.00 ৳"},
  ];

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
            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              transaction["title"],
              style: AppStyle.normalText,
            ),
            subtitle: Text(
              transaction["date"],
              style: AppStyle.normalText.copyWith(fontSize: 12),
            ),
            trailing: Text(
              transaction["amount"],
              style: AppStyle.normalText,
            ),
          ),
        );
      },
    );
  }
}
