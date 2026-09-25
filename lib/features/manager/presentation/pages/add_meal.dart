import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/core/widgets/success_message.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_state.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/core/theme/app_color.dart';

/// Placeholder value in the manager's member dropdown meaning "nothing
/// selected yet".
const String _selectMemberPlaceholder = "Select Member";

/// Reads role/identity from [AuthBloc] itself (like `meal_list.dart` does)
/// rather than taking them as constructor params — this used to default
/// to a hardcoded "Rifat" placeholder for whoever reached this screen
/// without a caller-supplied name (e.g. the standalone `/entry_meal_screen`
/// route), which is no longer needed now that a real session exists.
class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  DateTime selectedDate = DateTime.now();
  String? _selectedMemberId;

  // Meals — fixed to breakfast/lunch/dinner, matching what the server
  // actually supports (no arbitrary custom meal types).
  final Map<String, double> _meals = {
    "Breakfast": 0.5,
    "Lunch": 1,
    "Dinner": 1,
  };

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final email = authState is AuthAuthenticated ? authState.user.email : '';
    context.read<AddMealCubit>().loadMembers(email);
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
      if (!mounted) return;
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

  /// Submit meals
  void _submitMeal(bool isManager) {
    final memberId = isManager ? _selectedMemberId : context.read<AddMealCubit>().state.myMemberId;
    if (memberId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a member first.")),
      );
      return;
    }

    context.read<AddMealCubit>().submit(
      memberId: memberId,
      date: selectedDate,
      mealCounts: {
        for (final entry in _meals.entries) entry.key.toLowerCase(): entry.value,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final isManager =
        authState is AuthAuthenticated && authState.user.role == UserRole.manager;

    return Scaffold(
      appBar: CustomAppBar(title: "Add Meal", backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: BlocListener<AddMealCubit, AddMealState>(
        listener: (context, state) {
          if (state.status == AddMealStatus.success) {
            showSuccessMessage(message: "Meal added");
            Navigator.pop(context);
          } else if (state.status == AddMealStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Something went wrong"),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Date Picker
              GestureDetector(
                onTap: _pickDateTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Manager Only: User Selector
              if (isManager)
                BlocBuilder<AddMealCubit, AddMealState>(
                  buildWhen: (previous, current) =>
                      previous.members != current.members,
                  builder: (context, state) {
                    final dropdownMembers = <Member?>[null, ...state.members];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String?>(
                          value: _selectedMemberId,
                          isExpanded: true,
                          items: dropdownMembers.map((member) {
                            return DropdownMenuItem<String?>(
                              value: member?.id,
                              child: Text(
                                member?.name ?? _selectMemberPlaceholder,
                                style: TextStyle(
                                  color: member == null
                                      ? Colors.grey.shade600
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedMemberId = value);
                          },
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 20),

              /// Header Row
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Meals",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
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
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.normalTextColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _changeMealCount(meal, -0.5),
                            icon: Icon(
                              Icons.remove_circle,
                              color: AppColor.errorColor,
                              size: 28,
                            ),
                          ),
                          Text(
                            value % 1 == 0
                                ? value.toInt().toString()
                                : value.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _changeMealCount(meal, 0.5),
                            icon: Icon(
                              Icons.add_circle,
                              color: AppColor.successColor,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Submit Button
              BlocBuilder<AddMealCubit, AddMealState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return CustomAppButton(
                    onPressed: state.status == AddMealStatus.submitting
                        ? null
                        : () => _submitMeal(isManager),
                    text: state.status == AddMealStatus.submitting
                        ? "Submitting..."
                        : "Add Meal",
                    buttonColor: AppColor.primaryColor,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
