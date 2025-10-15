import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';

class AddMeal extends StatefulWidget {
  final String role; // "manager" or "member"
  final String currentUserName; // logged-in user's name

  const AddMeal({
    super.key,
    this.role = "manager",
    this.currentUserName = "Rifat",
  });

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  DateTime selectedDate = DateTime.now();

  // Dummy user list (replace with API data or GetX controller)
  final List<String> _users = [
    "Select Member",
    "Rifat Hasan",
    "Abdullah Al Mamun",
    "Sabbir Ahmed",
  ];

  late String selectedUser;

  // Meals (default)
  final Map<String, double> _meals = {
    "Breakfast": 0.5,
    "Lunch": 1,
    "Dinner": 1,
  };

  final TextEditingController _mealNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Default selected user
    selectedUser = widget.role == "manager"
        ? "Select Member"
        : widget.currentUserName;
  }

  /// Change meal count
  void _changeMealCount(String meal, double change) {
    setState(() {
      double newValue = (_meals[meal]! + change).clamp(0, 99);
      _meals[meal] = newValue;
    });
  }

  /// Pick date & time
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

  /// Add custom meal type
  void _addCustomMeal() {
    final mealName = _mealNameController.text.trim();

    if (mealName.isNotEmpty && !_meals.containsKey(mealName)) {
      if (mounted) {
        setState(() {
          _meals[mealName] = 0.5;
          _mealNameController.clear();
        });
      }
    }
  }



  /// Dialog to add new meal
  void _showAddMealDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Custom Meal"),
        content: TextField(
          controller: _mealNameController,
          decoration: const InputDecoration(
            hintText: "Enter meal name (e.g. Snacks)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _addCustomMeal,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
            ),
            child:  Text("Add",style: AppStyle.normalText.copyWith(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  /// Submit meals
  void _submitMeal() {
    if (widget.role == "manager" && selectedUser == "Select Member") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a member first.")),
      );
      return;
    }

    debugPrint("Role: ${widget.role}");
    debugPrint("User: $selectedUser");
    debugPrint("Date: $selectedDate");
    debugPrint("Meals: $_meals");

    // TODO: Save meal data logic here
  }

  @override
  Widget build(BuildContext context) {
    final bool isManager = widget.role == "manager";

    return Scaffold(

      appBar: CustomAppBar(
        title: "Add Meal",
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Date Picker
            GestureDetector(
              onTap: _pickDateTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.day.toString().padLeft(2, '0')}-"
                          "${selectedDate.month.toString().padLeft(2, '0')}-"
                          "${selectedDate.year}  "
                          "${selectedDate.hour.toString().padLeft(2, '0')}:"
                          "${selectedDate.minute.toString().padLeft(2, '0')} ${selectedDate.hour >= 12 ? 'PM' : 'AM'}",
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today, color: AppColor.primaryColor),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Manager Only: User Selector
            if (isManager)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedUser,
                    isExpanded: true,
                    items: _users.map((user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Text(
                          user,
                          style: TextStyle(
                            color: user == "Select Member"
                                ? Colors.grey.shade600
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUser = value!;
                      });
                    },
                  ),
                ),
              ),


            const SizedBox(height: 20),

            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Meals",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: _showAddMealDialog,
                  icon: const Icon(Icons.add_circle, color: AppColor.primaryColor, size: 30),
                  tooltip: "Add custom meal",
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Meal List
            Expanded(
              child: ListView.separated(
                itemCount: _meals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  String meal = _meals.keys.elementAt(index);
                  double value = _meals[meal]!;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            meal,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _changeMealCount(meal, -0.5),
                          icon: const Icon(Icons.remove_circle, color: Colors.red, size: 28),
                        ),
                        Text(
                          value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          onPressed: () => _changeMealCount(meal, 0.5),
                          icon: const Icon(Icons.add_circle, color: Colors.green, size: 28),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// Submit Button
            CustomAppButton(
              onPressed: _submitMeal,
              text: "Add Meal",
              buttonColor: AppColor.primaryColor,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
