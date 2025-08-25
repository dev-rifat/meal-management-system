import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';

class OperationGrid extends StatelessWidget {
  const OperationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> operations = [
      {"icon": Icons.list, "label": "Meal List"},
      {"icon": Icons.wallet, "label": "Wallet"},
      {"icon": Icons.event, "label": "Month Summary"},
      {"icon": Icons.money, "label": "Meal Summary"},
      {"icon": Icons.picture_as_pdf, "label": "Documents"},
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
          onTap: ()=>_onClick(index,context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.withOpacity(0.1), // AppColor removed for simplicity
                child: Icon(item['icon'], color: Colors.blue.shade800),
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
        context.push(AppRoute.myWallet);
        break;

      case 1:
        context.push(AppRoute.myWallet);

        break;

      case 2:
      //  context.push(AppRoute.settings);
        break;

      case 3:
       // context.push(AppRoute.helpCenter);
        break;

      default:
       // print('Invalid index: $index');
        break;
    }
  }

}
