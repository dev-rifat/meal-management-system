import 'package:dropdown_button2/dropdown_button2.dart' show DropdownButtonFormField2, ButtonStyleData;
import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/utils/app_color.dart';

class AddShareExpenseScreen extends StatefulWidget {
  const AddShareExpenseScreen({super.key});

  @override
  State<AddShareExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddShareExpenseScreen> {
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedMember;
  String? _selectedBillType; // <-- for radio-like single selection

  // Dynamic bill list
  final List<String> billTypes = ["WiFi", "Gas","Electricity","Khala","Water","Others"];

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
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            _title("Spent By"),
            const SizedBox(height: 12),
            _spentDropDown(),
            const SizedBox(height: 16),

            _title("Price"),
            const SizedBox(height: 12),
            CustomInputField(
              controller: _priceController,
              hitText: "Enter price",
              textInputType: TextInputType.number,

            ),
            const SizedBox(height: 16),

            _title("Bill Type"),
            const SizedBox(height: 12),
            Column(
              children: billTypes.map((bill) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0), // left/right padding
                  controlAffinity: ListTileControlAffinity.leading, // checkbox before text
                  title: Text(bill),
                  selectedTileColor: AppColor.primaryColor,
                  activeColor: AppColor.primaryColor, // checkbox border & tick color

                  value: _selectedBillType == bill,
                  onChanged: (bool? selected) {
                    setState(() {
                      _selectedBillType = selected! ? bill : null;
                    });
                  },
                );
              }).toList(),
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

  _appBar() => CustomAppBar(
    title: "Add Share Expense",
    backgroundColor: Colors.white,
  );

  Widget _title(String text) => Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black)),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
    debugPrint("Price: ${_priceController.text}");
    debugPrint("Member: $_selectedMember");
    debugPrint("Date: ${_dateController.text}");
    debugPrint("Bill Type: $_selectedBillType");
    debugPrint("Details: ${_detailsController.text}");
  }
}
