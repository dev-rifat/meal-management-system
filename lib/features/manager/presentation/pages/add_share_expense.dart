import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/core/widgets/success_message.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_state.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';

class AddShareExpenseScreen extends StatefulWidget {
  const AddShareExpenseScreen({super.key});

  @override
  State<AddShareExpenseScreen> createState() => _AddShareExpenseScreenState();
}

class _AddShareExpenseScreenState extends State<AddShareExpenseScreen> {
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  final _dateController = TextEditingController();

  String? _selectedMember;
  String? _selectedBillType;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(_selectedDate);
    context.read<AddShareExpenseCubit>().loadInitialData();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _detailsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

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
        _dateController.text = _formatDate(date);
      });
    }
  }

  void _addCustomBillType() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          "Add Custom Bill Type",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter bill name (e.g. Internet)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
            ),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                context.read<AddShareExpenseCubit>().addBillType(text);
                setState(() => _selectedBillType = text);
              }
              Navigator.pop(dialogContext);
            },
            child: Text("Add", style: AppStyle.normalText.copyWith(color: AppColor.cardColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Add Share Expense",
        backgroundColor: Colors.white,
      ),
      body: BlocListener<AddShareExpenseCubit, AddShareExpenseState>(
        listener: (context, state) {
          if (state.status == AddShareExpenseStatus.success) {
            showSuccessMessage(message: "Expense added");
            Navigator.pop(context);
          } else if (state.status == AddShareExpenseStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Something went wrong")),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Date"),
              const SizedBox(height: 10),
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
              const SizedBox(height: 18),
              _sectionTitle("Spent By"),
              const SizedBox(height: 10),
              BlocBuilder<AddShareExpenseCubit, AddShareExpenseState>(
                builder: (context, state) {
                  return _buildDropdown<String>(
                    value: _selectedMember,
                    hint: "Select Member",
                    items: state.members
                        .map((member) => DropdownMenuItem(value: member, child: Text(member)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedMember = val),
                  );
                },
              ),
              const SizedBox(height: 18),
              _sectionTitle("Price"),
              const SizedBox(height: 10),
              CustomInputField(
                controller: _priceController,
                hintText: "Enter amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 18),
              _sectionTitle("Bill Type"),
              const SizedBox(height: 10),
              BlocBuilder<AddShareExpenseCubit, AddShareExpenseState>(
                builder: (context, state) {
                  return _buildDropdown<String>(
                    value: _selectedBillType,
                    hint: "Select Bill Type",
                    items: state.billTypes
                        .map((bill) => DropdownMenuItem(value: bill, child: Text(bill)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedBillType = val),
                  );
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _addCustomBillType,
                  icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                  label: const Text(
                    "Add Custom Bill Type",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _sectionTitle("Details"),
              const SizedBox(height: 10),
              TextFormField(
                controller: _detailsController,
                maxLines: 3,
                decoration: _inputDecoration("Write details...", 15),
              ),
              const SizedBox(height: 40),
              BlocBuilder<AddShareExpenseCubit, AddShareExpenseState>(
                builder: (context, state) {
                  return CustomAppButton(
                    onPressed: state.status == AddShareExpenseStatus.submitting
                        ? null
                        : _submitExpense,
                    buttonColor: AppColor.primaryColor,
                    text: state.status == AddShareExpenseStatus.submitting
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

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField2<T>(
      value: value,
      isExpanded: true,
      decoration: _inputDecoration(hint),
      hint: Text(
        hint,
        style: const TextStyle(color: Colors.black54, fontSize: 15),
      ),
      items: items,
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 32,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, [double? horizontal = 0]) => InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: horizontal ?? 0, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
        ),
      );

  void _submitExpense() {
    final amount = double.tryParse(_priceController.text.trim());
    if (amount == null || _selectedMember == null || _selectedBillType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in price, spent by and bill type.")),
      );
      return;
    }

    // No dedicated title field for shared expenses — derive a reasonable
    // display title from the bill type instead (e.g. "WiFi Bill").
    context.read<AddShareExpenseCubit>().submit(
          title: "$_selectedBillType Bill",
          amount: amount,
          date: _selectedDate,
          details: _detailsController.text.trim(),
          spentBy: _selectedMember!,
          billType: _selectedBillType!,
        );
  }
}
