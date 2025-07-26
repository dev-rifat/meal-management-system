import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/features/deashboard/widgets/balance_swap_card.dart';
import 'package:mass_management/utils/app_color.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome",
        centerTitle: false,
        leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
        ),
        actions: const [
         
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            _balanceCard(),
            const SizedBox(height: 20),
            const Text(
              'Operations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _operationGrid(),
            const SizedBox(height: 20),
            const Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("No transactions yet."),
          ],
        ),
      ),
    );
  }

  /// Balance card widget
 



 Widget _balanceCard() =>BalanceCardSwitcher();
 

 
  /// Operations grid
  Widget _operationGrid() {
    final List<Map<String, dynamic>> operations = [
      {"icon": Icons.wallet, "label": "My Wallet"},
      {"icon": Icons.list, "label": "Meal List"},
      {"icon": Icons.event, "label": "Market Date"},
      {"icon": Icons.money, "label": "Summary"},
      {"icon": Icons.account_balance_wallet, "label": "Mess Wallet"},
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColor.primaryColor.withOpacity(0.2),
              child: Icon(item['icon'], color: Colors.blue.shade800),
            ),
            const SizedBox(height: 6),
            Text(
              item['label'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
