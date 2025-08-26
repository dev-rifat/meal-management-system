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

  final double breakfast = 0.5;
  final double lunch = 1.0;
  final double dinner = 1.0;

  @override
  Widget build(BuildContext context) {
    final double total = breakfast + lunch + dinner;
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 360;

    // Dynamic font and icon sizes
    final double fontSizeTitle = isSmallScreen ? 12 : 14;
    final double fontSizeValue = isSmallScreen ? 14 : 18;
    final double iconSize = isSmallScreen ? 22 : 18;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "Meal Details",
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          /// ✅ Filter Row
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 08.0),
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
                Text(
                  DateFormat('MMM yyyy').format(selectedDate),
                  style: AppStyle.normalText.copyWith(
                    color: AppColor.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 12,
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Custom Date Picker
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


/// ✅ Widget for the meal card section
class MealCard extends StatelessWidget {
  final DateTime date;
  final Size size;
  final double iconSize, fontSizeTitle, fontSizeValue;
  final double breakfast, lunch, dinner, total;

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
  });

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
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ Date Row
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
            const SizedBox(height: 12),

            /// ✅ Meal Items Row
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
    );
  }
}


/// ✅ Widget for individual meal items
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
