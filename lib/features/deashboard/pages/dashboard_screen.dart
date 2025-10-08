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
      appBar: _appBarTitle(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _balanceCard(),
            const SizedBox(height: 30),
           _titleText("Operations"),
            const SizedBox(height: 10),
            _operationGrid(),
          //  const SizedBox(height: 20),
            _titleText("Transaction History"),

            const SizedBox(height: 10),

            TransactionScreen(),
            //  const Text("No transactions yet."),
          ],
        ),
      ),
    );
  }

  /// Balance card widget

  Widget _balanceCard() => BalanceCardSwitcher();

  /// Operations grid
  Widget _operationGrid() => OperationGrid();

  PreferredSizeWidget? _appBarTitle() {
    return CustomAppBar(
      backgroundColor: AppColor.backgroundColor,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: AppStyle.titleText.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: AppColor.hintColor,
            ),
          ),
          Text(
            "devZone",
            style: AppStyle.titleText.copyWith(
              fontSize: Dimensions.fontSizeMid,
            ),
          ),
        ],
      ),
      centerTitle: false,
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blueAccent,
        child: Image.network("https://cdn.pixabay.com/photo/2023/01/31/01/50/crown-7756927_1280.png"),
      ),
      actions: const [Icon(Icons.notifications_none), SizedBox(width: 10)],
    );
  }

  _titleText(String s) =>  Text(
    s,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}
