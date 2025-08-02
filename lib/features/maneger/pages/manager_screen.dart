import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:mass_management/features/maneger/widgets/operations.dart';
import 'package:mass_management/features/maneger/widgets/pie_chat.dart' show ChartData, SummaryChart;
import 'package:mass_management/features/maneger/widgets/summary_card.dart';
import 'package:mass_management/utils/app_color.dart';

class MessManagerPage extends StatelessWidget {
  const MessManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: const [
                SummaryCard(title: '1', subtitle: 'Members'),
                SummaryCard(title: '৳710.00', subtitle: 'Total cost'),
                SummaryCard(title: '৳710.00', subtitle: 'Balance'),
              ],
            ),
            const SizedBox(height: 12),
            _summaryChart(),
            const SizedBox(height: 12),
            const OperationsSection(),
          ],
        ),
      ),
    );
  }

  _appBar() => CustomAppBar(
    leadingWidth: 300,
    leading:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Text("Manager",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
    ),
    backgroundColor: AppColor.backgroundColor,

  );
}



_summaryChart() => SummaryChart(
  data: [
    ChartData(label: 'Remaining', percentage: 16, color: Colors.green),
    ChartData(label: 'Shared Expense', percentage: 25, color: Colors.orange),
    ChartData(label: 'Food Expense', percentage: 30, color: Colors.deepPurple),
  ],
);



