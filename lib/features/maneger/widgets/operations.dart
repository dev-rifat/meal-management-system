import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/utils/app_color.dart' show AppColor;

class OperationsSection extends StatelessWidget {
  const OperationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> operations = [
      {'label': 'Add Market Expense', 'icon': Icons.playlist_add},
      {'label': 'Add Member Meal', 'icon': Icons.checklist},
      {'label': 'Deposit Money', 'icon': Icons.attach_money},
      {'label': 'Add Shared Expense', 'icon': Icons.groups},
      {'label': 'Add Market List', 'icon': Icons.calendar_today},
    ];

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
            itemCount: operations.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final op = operations[index];
              return InkWell(
                onTap: (){
                  if(index==0){
                    context.push(AppRoute.addMeal);

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
