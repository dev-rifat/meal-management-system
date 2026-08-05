import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/entities/manager_meal_entry.dart';

/// No backend exists for mess-management data yet, so this is an in-memory
/// store seeded with today's hardcoded demo values (the same ones the old
/// widgets used to hardcode directly). Registered as a lazy singleton so
/// every cubit in this feature mutates/reads the same in-memory state.
class ManagerLocalDataSource {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Groceries',
      amount: 1200,
      type: ExpenseType.market,
      date: DateTime(2025, 8, 10),
      details: 'Vegetables, fruits, and milk',
      spentBy: 'Rifat Al Hasan',
    ),
    Expense(
      id: '2',
      title: 'WiFi Bill',
      amount: 800,
      type: ExpenseType.share,
      date: DateTime(2025, 8, 5),
      details: 'Monthly broadband bill',
      spentBy: 'Rifat Al Hasan',
      billType: 'WiFi',
    ),
    Expense(
      id: '3',
      title: 'Gas Cylinder',
      amount: 1500,
      type: ExpenseType.share,
      date: DateTime(2025, 8, 2),
      details: 'House gas bill',
      spentBy: 'Rifat Al Hasan',
      billType: 'Gas',
    ),
    Expense(
      id: '4',
      title: 'Fish & Meat',
      amount: 2000,
      type: ExpenseType.market,
      date: DateTime(2025, 8, 1),
      details: 'Weekly protein shopping',
      spentBy: 'Rifat Al Hasan',
    ),
  ];
  int _nextExpenseId = 5;

  final List<String> _billTypes = [
    'WiFi',
    'Gas',
    'Electricity',
    'Khala',
    'Water',
    'Others',
  ];

  final List<String> _members = [
    'Rifat Al Hasan',
    'Abdullah Al Mamun',
    'Sabbir Ahmed',
  ];

  /// Demo-seeded count for the manager dashboard's "Members" summary card.
  /// Deliberately kept as a local literal (matching current behavior)
  /// instead of deriving it from [_members] or any other feature.
  static const int _membersCount = 1;

  final List<ManagerMealEntry> _mealEntries = [];

  List<Expense> get allExpenses => List.unmodifiable(_expenses);

  List<Expense> getExpenses({String query = '', ExpenseType? filter}) {
    final normalizedQuery = query.trim().toLowerCase();
    return _expenses.where((expense) {
      final matchesType = filter == null || expense.type == filter;
      final matchesQuery =
          normalizedQuery.isEmpty || expense.title.toLowerCase().contains(normalizedQuery);
      return matchesType && matchesQuery;
    }).toList();
  }

  int getMembersCount() => _membersCount;

  Expense addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
  }) {
    final expense = Expense(
      id: (_nextExpenseId++).toString(),
      title: title,
      amount: amount,
      type: ExpenseType.market,
      date: date,
      details: details,
      spentBy: spentBy,
    );
    _expenses.insert(0, expense);
    return expense;
  }

  Expense addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required String spentBy,
    required String billType,
  }) {
    final expense = Expense(
      id: (_nextExpenseId++).toString(),
      title: title,
      amount: amount,
      type: ExpenseType.share,
      date: date,
      details: details,
      spentBy: spentBy,
      billType: billType,
    );
    _expenses.insert(0, expense);
    return expense;
  }

  List<String> getBillTypes() => List.unmodifiable(_billTypes);

  List<String> addCustomBillType(String billType) {
    final trimmed = billType.trim();
    if (trimmed.isNotEmpty && !_billTypes.contains(trimmed)) {
      _billTypes.add(trimmed);
    }
    return List.unmodifiable(_billTypes);
  }

  List<String> getMembersForDropdown() => List.unmodifiable(_members);

  ManagerMealEntry addMealEntry({
    required DateTime date,
    required Map<String, double> mealCounts,
    required String submittedFor,
    required String role,
  }) {
    final entry = ManagerMealEntry(
      date: date,
      mealCounts: Map.unmodifiable(mealCounts),
      submittedFor: submittedFor,
      role: role,
    );
    _mealEntries.add(entry);
    return entry;
  }
}
