import 'package:dropdown_button2/dropdown_button2.dart' show DropdownButtonFormField2, ButtonStyleData;
import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/utils/app_color.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedMember;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateController.text =
    "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      _dateController.text =
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Price"),
            const SizedBox(height: 12),
            CustomInputField(
              controller: _priceController,
              hitText: "Enter price",
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
                  hitText: "Select Date",
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
            CustomAppButton(
              onPressed: _submitExpense,

              buttonColor: AppColor.primaryColor,
              text: "Submit Expense",
            ),
          ],
        ),
      ),
    );
  }

   _appBar() =>  CustomAppBar(
    title: "Add Expense",
    backgroundColor: Colors.white,
  );

  Widget _title(String text) => Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.black)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  );

  Widget _spentDropDown() => DropdownButtonFormField2(
    value: _selectedMember,

    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black)),
      // Remove hintText here to avoid conflict
    ),

    hint: const Align(
      alignment: Alignment.centerLeft, // Adjust to left, center or right
      child: Text(
        "Select Member",
        style: TextStyle(color: Colors.black54),
      ),
    ),
    alignment: Alignment.center,
    isExpanded: true,
    items: const [
      DropdownMenuItem(value: "1", child: Text("Member 1")),
      DropdownMenuItem(value: "2", child: Text("Member 2")),
    ],
    onChanged: (val) {
      setState(() {
        _selectedMember = val;
      });
    },
  );


  void _submitExpense() {
    // Add validation here if needed
    debugPrint("Price: ${_priceController.text}");
    debugPrint("Member: $_selectedMember");
    debugPrint("Date: ${_dateController.text}");
    debugPrint("Details: ${_detailsController.text}");
  }
}
