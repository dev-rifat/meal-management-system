import 'package:dropdown_button2/dropdown_button2.dart'
    show DropdownButtonFormField2;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/core/widgets/success_message.dart';
import 'package:mass_management/core/utils/date_formatter.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_state.dart';
import 'package:mass_management/core/theme/app_color.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedMember;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateController.text = formatDateYmd(_selectedDate);
    context.read<AddExpenseCubit>().loadMembers();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _detailsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
        _dateController.text = formatDateYmd(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: BlocListener<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          if (state.status == AddExpenseStatus.success) {
            showSuccessMessage(message: "Expense added");
            Navigator.pop(context);
          } else if (state.status == AddExpenseStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Something went wrong"),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Title"),
              const SizedBox(height: 12),
              CustomInputField(
                controller: _titleController,
                hintText: "Enter expense title",
              ),
              const SizedBox(height: 16),
              _title("Price"),
              const SizedBox(height: 12),
              CustomInputField(
                controller: _priceController,
                hintText: "Enter price",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _title("Spent By"),
              const SizedBox(height: 12),
              _spentDropDown(),
              const SizedBox(height: 16),
              _title("Date"),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: CustomInputField(
                    controller: _dateController,
                    hintText: "Select Date",
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _title("Details"),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detailsController,
                maxLines: 3,
                decoration: _inputDecoration("Write details..."),
              ),
              const SizedBox(height: 50),
              BlocBuilder<AddExpenseCubit, AddExpenseState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return CustomAppButton(
                    onPressed: state.status == AddExpenseStatus.submitting
                        ? null
                        : _submitExpense,
                    buttonColor: AppColor.primaryColor,
                    text: state.status == AddExpenseStatus.submitting
                        ? "Submitting..."
                        : "Submit Expense",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() =>
      CustomAppBar(title: "Add Expense", backgroundColor: Colors.white);

  Widget _title(String text) => Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  );

  Widget _spentDropDown() {
    return BlocBuilder<AddExpenseCubit, AddExpenseState>(
      buildWhen: (previous, current) => previous.members != current.members,
      builder: (context, state) {
        return DropdownButtonFormField2(
          value: _selectedMember,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          hint: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Member",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          alignment: Alignment.center,
          isExpanded: true,
          items: state.members
              .map(
                (member) =>
                    DropdownMenuItem(value: member, child: Text(member)),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedMember = val;
            });
          },
        );
      },
    );
  }

  void _submitExpense() {
    final amount = double.tryParse(_priceController.text.trim());
    if (_titleController.text.trim().isEmpty ||
        amount == null ||
        _selectedMember == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in title, price and spent by."),
        ),
      );
      return;
    }

    context.read<AddExpenseCubit>().submit(
      title: _titleController.text.trim(),
      amount: amount,
      date: _selectedDate,
      details: _detailsController.text.trim(),
      spentBy: _selectedMember!,
    );
  }
}
