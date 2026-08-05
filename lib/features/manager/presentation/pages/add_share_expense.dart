import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_app_button.dart';
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

  final List<String> billTypes = [
    "WiFi",
    "Gas",
    "Electricity",
    "Khala",
    "Water",
    "Others"
  ];

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

  void _addCustomBillType() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
            ),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty && !billTypes.contains(text)) {
                setState(() {
                  billTypes.add(text);
                  _selectedBillType = text;
                });
              }
              Navigator.pop(context);
            },
            child:  Text("Add",style: AppStyle.normalText.copyWith(color: AppColor.cardColor),),
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
      body: SingleChildScrollView(
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
                  hitText: "Select Date",
                  suffixIcon: const Icon(Icons.calendar_month),
                ),
              ),
            ),

            const SizedBox(height: 18),
            _sectionTitle("Spent By"),
            const SizedBox(height: 10),
            _buildDropdown<String>(
              value: _selectedMember,
              hint: "Select Member",
              items: const [
                DropdownMenuItem(value: "1", child: Text("Member 1")),
                DropdownMenuItem(value: "2", child: Text("Member 2")),
              ],
              onChanged: (val) => setState(() => _selectedMember = val),
            ),

            const SizedBox(height: 18),
            _sectionTitle("Price"),
            const SizedBox(height: 10),
            CustomInputField(
              controller: _priceController,
              hitText: "Enter amount",
              textInputType: TextInputType.number,
            ),

            const SizedBox(height: 18),
            _sectionTitle("Bill Type"),
            const SizedBox(height: 10),
            _buildDropdown<String>(
              value: _selectedBillType,
              hint: "Select Bill Type",
              items: billTypes
                  .map((bill) => DropdownMenuItem(
                value: bill,
                child: Text(bill),
              ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedBillType = val),
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
              decoration: _inputDecoration("Write details...",15),
            ),

            const SizedBox(height: 40),
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

  InputDecoration _inputDecoration(String hint,[double ?horizontal=0]) => InputDecoration(
    hintText: hint,
    contentPadding:
     EdgeInsets.symmetric(horizontal: horizontal??0, vertical: 12),
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
    debugPrint("Date: ${_dateController.text}");
    debugPrint("Member: $_selectedMember");
    debugPrint("Price: ${_priceController.text}");
    debugPrint("Bill Type: $_selectedBillType");
    debugPrint("Details: ${_detailsController.text}");
  }
}
