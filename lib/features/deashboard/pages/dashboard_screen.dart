import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/features/deashboard/widgets/balance_swap_card.dart';
import 'package:mass_management/features/deashboard/widgets/operation_grid.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';
import 'package:mass_management/utils/dimensions.dart';

import 'transaction_history.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: AppColor.backgroundColor,

        title: "",
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Evening",style: AppStyle.titleText.copyWith(fontSize: Dimensions.fontSizeMid),)
          ],
        ),
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

            TransactionScreen(),
          //  const Text("No transactions yet."),
          ],
        ),
      ),
    );
  }

  /// Balance card widget
 



 Widget _balanceCard() =>BalanceCardSwitcher();
 

 
  /// Operations grid
  Widget _operationGrid()=>OperationGrid();
}
