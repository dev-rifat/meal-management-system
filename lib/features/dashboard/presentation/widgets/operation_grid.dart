import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/utils/app_color.dart';

/// Pure navigation grid — no business data of its own, just routes to the
/// meal list / wallet / monthly summary screens.
class OperationGrid extends StatelessWidget {
  const OperationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> operations = [
      {"icon": Icons.list, "label": "Meal List"},
      {"icon": Icons.wallet, "label": "Wallet"},
      {"icon": Icons.event, "label": "Month Summary"},
    ];

    return GridView.builder(
      itemCount: operations.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = operations[index];
        return GestureDetector(
          onTap: () => _onClick(index, context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.primaryColor.withValues(alpha: 0.1),
                child: Icon(item['icon'], color: AppColor.primaryColor),
              ),
              const SizedBox(height: 6),
              Text(
                item['label'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onClick(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.push(AppRoute.mealList);
        break;

      case 1:
        context.push(AppRoute.myWallet);
        break;

      case 2:
        context.push(AppRoute.monthlySummary);
        break;
    }
  }
}
