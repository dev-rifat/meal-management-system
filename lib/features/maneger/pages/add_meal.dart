import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:mass_management/core/widgets/custom_app_button.dart' show CustomAppButton;
import 'package:mass_management/utils/app_color.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _DailyMealEntryScreenState();
}

class _DailyMealEntryScreenState extends State<AddMeal> {
  double breakfast = 0.5;
  double lunch = 1;
  double dinner = 1;
  DateTime selectedDate = DateTime.now();

  void _changeMealCount(String meal, double change) {
    setState(() {
      if (meal == "breakfast") {
        breakfast = (breakfast + change).clamp(0, 99);
      } else if (meal == "lunch") {
        lunch = (lunch + change).clamp(0, 99);
      } else if (meal == "dinner") {
        dinner = (dinner + change).clamp(0, 99);
      }
    });
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Selector
            GestureDetector(
              onTap: _pickDateTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.day.toString().padLeft(2, '0')}-"
                          "${selectedDate.month.toString().padLeft(2, '0')}-"
                          "${selectedDate.year} "
                          "${selectedDate.hour.toString().padLeft(2, '0')}:"
                          "${selectedDate.minute.toString().padLeft(2, '0')} ${selectedDate.hour >= 12 ? 'PM' : 'AM'}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Icon(Icons.calendar_today, color: AppColor.primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColor.primaryColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "User Name",
                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      mealCounter("Breakfast", breakfast, () => _changeMealCount("breakfast", 0.5), () => _changeMealCount("breakfast", -0.5)),
                      mealCounter("Lunch", lunch, () => _changeMealCount("lunch", 0.5), () => _changeMealCount("lunch", -0.5)),
                      mealCounter("Dinner", dinner, () => _changeMealCount("dinner", 0.5), () => _changeMealCount("dinner", -0.5)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Update Button
            CustomAppButton(
              onPressed: _submitExpense,
              buttonColor: AppColor.primaryColor,

              text: "Update Meal",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  _appBar() => CustomAppBar(
    title: "Add Daily Meal",
    backgroundColor: Colors.white,
  );

  Widget mealCounter(String label, double value, VoidCallback onIncrement, VoidCallback onDecrement) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
        const SizedBox(height: 4),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.blue,size: 30),
          onPressed: onIncrement,
        ),
        Text(
          value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1),
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red,size: 30),
          onPressed: onDecrement,
        ),
      ],
    );
  }

  _submitExpense() {
    // Handle save/update logic here
  }
}
