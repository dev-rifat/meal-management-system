import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';

class MonthlySummary extends StatefulWidget {
  const MonthlySummary({super.key});

  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
  String selectedFilter = "This Month";
  DateTime? startMonth;
  DateTime? endMonth;
  String searchQuery = "";

  final List<Map<String, dynamic>> allMembers = [
    {"name": "Rifat Hasan", "totalMeal": 45, "totalCost": 2700, "paid": 2800},
    {"name": "Riaz Hasan", "totalMeal": 40, "totalCost": 2400, "paid": 2400},
    {"name": "Kamruzamam Ahmed", "totalMeal": 38, "totalCost": 2280, "paid": 2000},
    {"name": "Shakil Ahmed", "totalMeal": 38, "totalCost": 2280, "paid": 2000},
    {"name": "Rahat Hasan", "totalMeal": 38, "totalCost": 2280, "paid": 2000},
  ];

  List<Map<String, dynamic>> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = List.from(allMembers);
  }

  // 🔹 Filter members by search text
  void _filterMembers(String query) {
    setState(() {
      searchQuery = query;
      filteredMembers = allMembers
          .where((m) => m["name"].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // 🔹 Month range picker
  Future<void> _pickMonthRange(BuildContext context) async {
    final start = await showMonthPicker(
      context: context,
      initialDate: startMonth ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (start != null) {
      final end = await showMonthPicker(
        context: context,
        initialDate: endMonth ?? start,
        firstDate: start,
        lastDate: DateTime(2050),
      );

      if (end != null) {
        setState(() {
          startMonth = start;
          endMonth = end;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCost = 7380;
    double totalMeal = 123;
    double mealRate = totalCost / totalMeal;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leadingWidth: 400,

        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),

            Expanded(child: _buildSearchBar())
          ],
        ),
        actions: [
          _buildFilterDropdown(context),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedFilter == "Custom" && startMonth != null && endMonth != null)
              _buildSelectedRange(),

            _buildSummaryCard(totalCost, totalMeal, mealRate),

            const SizedBox(height: 20),
            const Text(
              "Mess Members",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),



            const SizedBox(height: 10),
            _buildMemberList(mealRate),
          ],
        ),
      ),
    );
  }

  // 🔹 Filter Dropdown
  Widget _buildFilterDropdown(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButton<String>(
        value: selectedFilter,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: const [
          DropdownMenuItem(value: "This Month", child: Text("This Month")),
          DropdownMenuItem(value: "Last Month", child: Text("Last Month")),
          DropdownMenuItem(value: "Custom", child: Text("Custom")),
        ],
        onChanged: (value) async {
          if (value != null) {
            setState(() => selectedFilter = value);
            if (value == "Custom") await _pickMonthRange(context);
          }
        },
      ),
    );
  }

  // 🔹 Selected Month Range Display
  Widget _buildSelectedRange() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.date_range, color: Colors.teal),
          const SizedBox(width: 8),
          Text(
            "${DateFormat('MMMM yyyy').format(startMonth!)} → ${DateFormat('MMMM yyyy').format(endMonth!)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Summary Card
  Widget _buildSummaryCard(double totalCost, double totalMeal, double mealRate) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      color: AppColor.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _summaryItem("Total Cost", "৳${totalCost.toStringAsFixed(0)}"),

            Container(width: 1,height: 40,color: Colors.white,),
            _summaryItem("Meal Rate", "৳${mealRate.toStringAsFixed(2)}"),
            Container(width: 1,height: 40,color: Colors.white,),
            _summaryItem("Total Meals", totalMeal.toStringAsFixed(0)),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: AppStyle.normalText.copyWith(color: AppColor.alertBgColor, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppStyle.normalText.copyWith(color: AppColor.cardColor, fontSize: 16),
        ),
      ],
    );
  }

  // 🔹 Search Bar
  Widget _buildSearchBar() {
    return TextField(
      onChanged: _filterMembers,
      decoration: InputDecoration(
        hintText: "Search member...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 🔹 Member List
  Widget _buildMemberList(double mealRate) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredMembers.length,
      itemBuilder: (context, index) {
        final member = filteredMembers[index];
        double mealCost = member["totalMeal"] * mealRate;
        double due = member["paid"] - mealCost;

        return _buildMemberCard(member, mealCost, due);
      },
    );
  }

  // 🔹 Individual Member Card
  Widget _buildMemberCard(Map<String, dynamic> member, double mealCost, double due) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      color: AppColor.disableColor.withValues(alpha: 0.5),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          member["name"],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Meal: ${member["totalMeal"]}"),
            Text("Total Cost: ৳${member["totalCost"]}"),
            Text("Meal Cost: ৳${mealCost.toStringAsFixed(0)}"),


            Text(
              due >= 0
                  ? "Status: ✅ Paid (৳${due.toStringAsFixed(0)} extra)"
                  : "Status: ❌ Due (৳${due.abs().toStringAsFixed(0)})",
              style: TextStyle(
                color: due >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
