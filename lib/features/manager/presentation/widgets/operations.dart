import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/theme/app_color.dart' show AppColor;

class OperationsSection extends StatelessWidget {
  const OperationsSection({super.key});

  // Static across all instances/builds — this data never changes at
  // runtime, so it's hoisted out of build() to avoid reallocating the list
  // (and its 4 map literals) on every rebuild of this widget.
  static const List<Map<String, dynamic>> _operations = [
    {'label': 'Add Market Expense', 'icon': Icons.playlist_add},
    {'label': 'Add Member Meal', 'icon': Icons.checklist},
    {'label': 'Add Shared Expense', 'icon': Icons.groups},
    {'label': 'Expense Lists', 'icon': Icons.format_list_bulleted_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _operations.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final op = _operations[index];
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    context.push(AppRoute.addExpense);
                  } else if (index == 1) {
                    context.push(AppRoute.addMeal);
                  } else if (index == 2) {
                    context.push(AppRoute.addShareExpense);
                  } else {
                    context.push(AppRoute.expenseList);
                  }
                },
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColor.primaryColor,
                        child: Icon(op['icon'], color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        op['label'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
