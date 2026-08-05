import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';

class MealDetailsPage extends StatefulWidget {
  const MealDetailsPage({super.key});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "This Month";

  // Horizontal filter selections
  String selectedCategory = "All";
  String selectedStatusFilter = "All";

  final double breakfast = 0.5;
  final double lunch = 1.0;
  final double dinner = 1.0;

  List<String> statuses = [
    "Pending", "Approved", "Rejected", "Pending", "Approved", "Rejected",
    "Pending", "Approved", "Rejected", "Pending", "Approved", "Rejected"
  ];

  final List<String> statusFilters = ["All", "Pending", "Approved", "Rejected"];

  @override
  Widget build(BuildContext context) {
    final double total = breakfast + lunch + dinner;
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 360;

    final double fontSizeTitle = isSmallScreen ? 12 : 14;
    final double fontSizeValue = isSmallScreen ? 14 : 16;
    final double iconSize = isSmallScreen ? 22 : 18;

    // Apply status filter
    List<String> filteredStatuses = statuses.where((status) {
      if (selectedStatusFilter == "All") return true;
      return status == selectedStatusFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "",
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,

        actions: [
          /// ✅ Date Dropdown Filter
          Container(
            //width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButton<String>(
              value: selectedFilter,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: "This Month", child: Text("This Month")),
                DropdownMenuItem(value: "Last Month", child: Text("Last Month")),
                DropdownMenuItem(value: "Custom", child: Text("Custom")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                  if (value == "Custom") {
                    _pickDate(context);
                  }
                });
              },
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [


          /// ✅ Horizontal Filter Bar (Category + Status)
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...statusFilters.map((status) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      showCheckmark: false,
                      elevation: 0,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),

                      label: Text(status),
                      selected: selectedStatusFilter == status,
                      onSelected: (_) {
                        setState(() {
                          selectedStatusFilter = status;
                        });
                      },
                      selectedColor: AppColor.primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: selectedStatusFilter == status ? Colors.white : Colors.black,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),

          /// ✅ Filtered Meal Cards
          Expanded(
            child: ListView.builder(
              itemCount: filteredStatuses.length,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              itemBuilder: (context, index) => MealCard(
                date: selectedDate,
                size: size,
                iconSize: iconSize,
                fontSizeTitle: fontSizeTitle,
                fontSizeValue: fontSizeValue,
                breakfast: breakfast,
                lunch: lunch,
                dinner: dinner,
                total: total,
                status: filteredStatuses[index],
                onStatusChange: (newStatus) {
                  setState(() {
                    statuses[index] = newStatus;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

/// ✅ Meal Card Widget
class MealCard extends StatelessWidget {
  final DateTime date;
  final Size size;
  final double iconSize, fontSizeTitle, fontSizeValue;
  final double breakfast, lunch, dinner, total;
  final String status;
  final ValueChanged<String> onStatusChange;

  const MealCard({
    super.key,
    required this.date,
    required this.size,
    required this.iconSize,
    required this.fontSizeTitle,
    required this.fontSizeValue,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.total,
    required this.status,
    required this.onStatusChange,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.black54, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEE, MMM dd, yyyy').format(date),
                              style: AppStyle.normalText.copyWith(
                                color: AppColor.hintColor,
                                fontSize: fontSizeTitle - 1,
                              ),
                            ),
                          ],
                        ),
                        (status == "Pending")
                            ? PopupMenuButton<String>(
                          onSelected: onStatusChange,
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: "Approved", child: Text("Approve")),
                            const PopupMenuItem(value: "Rejected", child: Text("Reject")),
                          ],
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  status,
                                  style: AppStyle.normalText.copyWith(
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizeTitle,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, size: 20),
                              ],
                            ),
                          ),
                        )
                            : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status,
                            style: AppStyle.normalText.copyWith(
                              color: _getStatusColor(status),
                              fontWeight: FontWeight.w500,
                              fontSize: fontSizeTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MealItem("Breakfast", breakfast, Icons.free_breakfast,
                            iconSize, fontSizeTitle, fontSizeValue),
                        MealItem("Lunch", lunch, Icons.lunch_dining, iconSize,
                            fontSizeTitle, fontSizeValue),
                        MealItem("Dinner", dinner, Icons.dinner_dining, iconSize,
                            fontSizeTitle, fontSizeValue),
                        MealItem("Total", total, Icons.summarize, iconSize,
                            fontSizeTitle, fontSizeValue),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealItem extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final double iconSize, titleSize, valueSize;

  const MealItem(this.title, this.value, this.icon, this.iconSize,
      this.titleSize, this.valueSize,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: iconSize),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppStyle.normalText.copyWith(
            fontSize: titleSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(1),
          style: AppStyle.normalText.copyWith(
            fontSize: valueSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
