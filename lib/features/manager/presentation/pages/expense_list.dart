import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/widgets/app_input_field.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_state.dart';
import 'package:mass_management/utils/app_color.dart' show AppColor;

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ExpenseListCubit>().load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        children: [
          // Search bar — now actually wired to filter results (was a no-op
          // before: the controller existed but had no onChanged callback).
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomInputField(
              controller: _searchController,
              hintText: "Search by expense title",
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context.read<ExpenseListCubit>().search('');
                },
              ),
              onChanged: (value) => context.read<ExpenseListCubit>().search(value),
            ),
          ),

          // Filter buttons
          BlocBuilder<ExpenseListCubit, ExpenseListState>(
            builder: (context, state) {
              return SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _buildFilterChip(context, null, state.filter),
                    _buildFilterChip(context, ExpenseType.market, state.filter),
                    _buildFilterChip(context, ExpenseType.share, state.filter),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // Expense list
          Expanded(
            child: BlocBuilder<ExpenseListCubit, ExpenseListState>(
              builder: (context, state) {
                if (state.status == ExpenseListStatus.loading && state.expenses.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.expenses.isEmpty) {
                  return const Center(child: Text('No expenses found'));
                }
                return ListView.builder(
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = state.expenses[index];
                    final isMarket = expense.type == ExpenseType.market;
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      elevation: 0,
                      color: AppColor.hintColor.withValues(alpha: 0.1),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isMarket ? Colors.green : Colors.blue,
                          child: Icon(
                            isMarket ? Icons.shopping_cart : Icons.people,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          expense.title,
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expense.details),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(_formatDate(expense.date), style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                            // Real spentBy field now, instead of the
                            // hardcoded "@Rifat Al Hasan" shown on every item.
                            Text("@${expense.spentBy}", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "৳${expense.amount.toStringAsFixed(0)}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isMarket
                                    ? Colors.green.withValues(alpha: 0.2)
                                    : Colors.blue.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isMarket ? "Market" : "Share",
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  Widget _buildFilterChip(BuildContext context, ExpenseType? type, ExpenseType? selectedFilter) {
    final bool isSelected = type == selectedFilter;
    final label = type == ExpenseType.market
        ? "Market Expense"
        : type == ExpenseType.share
            ? "Share Expense"
            : "All";
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        elevation: 0,
        side: BorderSide.none,
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => context.read<ExpenseListCubit>().filterByType(type),
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
