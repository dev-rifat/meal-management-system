import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/utils/app_color.dart' show AppColor;

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Map<String, dynamic>> expenses = [
    {
      "title": "Groceries",
      "amount": 1200,
      "type": "Market",
      "date": "2025-08-10",
      "details": "Vegetables, fruits, and milk"
    },
    {
      "title": "WiFi Bill",
      "amount": 800,
      "type": "Share",
      "date": "2025-08-05",
      "details": "Monthly broadband bill"
    },
    {
      "title": "Gas Cylinder",
      "amount": 1500,
      "type": "Share",
      "date": "2025-08-02",
      "details": "House gas bill"
    },
    {
      "title": "Fish & Meat",
      "amount": 2000,
      "type": "Market",
      "date": "2025-08-01",
      "details": "Weekly protein shopping"
    },
  ];

  final _searchController = TextEditingController();
  String selectedFilter = "All"; // default filter

  List<Map<String, dynamic>> get filteredExpenses {
    if (selectedFilter == "All") return expenses;
    return expenses.where((e) => e["type"] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomInputField(
              controller: _searchController,
              hitText: "Search by expense title",
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.clear),
            ),
          ),

          // Filter buttons
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildFilterChip("All"),
                _buildFilterChip("Market"),
                _buildFilterChip("Share"),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Expense list
          Expanded(
            child: ListView.builder(
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                final expense = filteredExpenses[index];
                final isMarket = expense["type"] == "Market";
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 0,
                  color: AppColor.hintColor.withValues(alpha: 0.1),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                      isMarket ? Colors.green : Colors.blue,
                      child: Icon(
                        isMarket ? Icons.shopping_cart : Icons.people,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(expense["title"], style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(expense["details"]),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(expense["date"],
                                style: const TextStyle(color: Colors.grey)),


                          ],
                        ),
                        Text("@Rifat Al Hasan",
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "৳${expense["amount"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isMarket
                                ? Colors.green.withOpacity(0.2)
                                : Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            expense["type"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isMarket ? Colors.green : Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        elevation: 0,
        side: BorderSide.none,
        
        label: Text(
          label == "Market"
              ? "Market Expense"
              : label == "Share"
              ? "Share Expense"
              : "All",
        ),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            selectedFilter = label;
          });
        },
        showCheckmark: false,
        selectedColor: AppColor.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}

_appBar() => CustomAppBar(
  title: "All Expense",
  backgroundColor: Colors.white,
);
