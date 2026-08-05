import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';

/// Purely in-memory dashboard data. There is no backend for
/// mess-management data yet, so every figure here is seeded with the same
/// literal values the old hardcoded widgets used — the app looks identical
/// at first load, but mutations (e.g. approving a meal) now actually
/// persist for the lifetime of this data source instead of being redrawn
/// from scratch on every build.
abstract class DashboardLocalDataSource {
  List<BalanceSummary> getBalanceSummaries();

  BalanceSummary getWalletSummary();

  List<Transaction> getTransactions();

  List<MealRecord> getMealsForMonth({required DateTime month, MealStatus? status});

  MealRecord updateMealStatus({required String id, required MealStatus status});

  /// `monthAnchor == null` means "the current month".
  MonthlySummaryResult getMonthlySummary({DateTime? monthAnchor});
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  DashboardLocalDataSourceImpl() : _meals = _seedMeals();

  // --- Balance cards (dashboard) -----------------------------------------

  final List<BalanceSummary> _balanceSummaries = const [
    BalanceSummary(
      label: "20 Aug - 20 Sep \n2025",
      mealRate: 46.7,
      deposit: 12600,
      expense: 2000,
    ),
    BalanceSummary(
      label: "Personal Balance",
      balance: 2000.00,
      deposit: 1500.00,
      expense: 500.00,
    ),
  ];

  // --- Wallet summary ------------------------------------------------------

  final BalanceSummary _walletSummary = const BalanceSummary(
    label: "My Wallet",
    balance: -4912.00,
    mealRate: 2.50,
    deposit: 1618.00,
    expense: 1880.00,
  );

  // --- Transactions (shared by dashboard + wallet) --------------------------

  final List<Transaction> _transactions = [
    Transaction(title: "Deposit", date: DateTime(2025, 7, 29), amount: 8.00),
    Transaction(title: "Shared Expense", date: DateTime(2025, 7, 29), amount: 100.00),
    Transaction(title: "Personal Expense", date: DateTime(2025, 7, 29), amount: 100.00),
    Transaction(title: "Food Cost", date: DateTime(2025, 7, 29), amount: 100.00),
    Transaction(title: "Deposit", date: DateTime(2025, 7, 29), amount: 600.00),
  ];

  // --- Meals -----------------------------------------------------------------

  List<MealRecord> _meals;

  static const double _breakfast = 0.5;
  static const double _lunch = 1.0;
  static const double _dinner = 1.0;

  static const List<MealStatus> _statusCycle = [
    MealStatus.pending,
    MealStatus.approved,
    MealStatus.rejected,
  ];

  /// Seeds 12 records (matching the old dummy list's length) spread across
  /// the current month so "This Month"/"Last Month"/"Custom" filtering has
  /// real per-item dates to work with.
  static List<MealRecord> _seedMeals() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(12, (index) {
      final day = (index % daysInMonth) + 1;
      return MealRecord(
        id: 'meal-$index',
        date: DateTime(now.year, now.month, day),
        breakfast: _breakfast,
        lunch: _lunch,
        dinner: _dinner,
        status: _statusCycle[index % _statusCycle.length],
      );
    });
  }

  // --- Monthly summary ---------------------------------------------------------

  static const double _baseTotalCost = 7380;
  static const double _baseTotalMeal = 123;

  static const List<MonthlySummaryEntry> _baseMembers = [
    MonthlySummaryEntry(name: "Rifat Hasan", totalMeal: 45, totalCost: 2700, paid: 2800),
    MonthlySummaryEntry(name: "Riaz Hasan", totalMeal: 40, totalCost: 2400, paid: 2400),
    MonthlySummaryEntry(name: "Kamruzamam Ahmed", totalMeal: 38, totalCost: 2280, paid: 2000),
    MonthlySummaryEntry(name: "Shakil Ahmed", totalMeal: 38, totalCost: 2280, paid: 2000),
    MonthlySummaryEntry(name: "Rahat Hasan", totalMeal: 38, totalCost: 2280, paid: 2000),
  ];

  @override
  List<BalanceSummary> getBalanceSummaries() => List.unmodifiable(_balanceSummaries);

  @override
  BalanceSummary getWalletSummary() => _walletSummary;

  @override
  List<Transaction> getTransactions() => List.unmodifiable(_transactions);

  @override
  List<MealRecord> getMealsForMonth({required DateTime month, MealStatus? status}) {
    return _meals.where((meal) {
      final sameMonth = meal.date.year == month.year && meal.date.month == month.month;
      if (!sameMonth) return false;
      if (status == null) return true;
      return meal.status == status;
    }).toList();
  }

  @override
  MealRecord updateMealStatus({required String id, required MealStatus status}) {
    final index = _meals.indexWhere((meal) => meal.id == id);
    if (index == -1) {
      throw const NotFoundException('Meal record not found.');
    }
    final updated = _meals[index].copyWith(status: status);
    _meals = List.of(_meals)..[index] = updated;
    return updated;
  }

  @override
  MonthlySummaryResult getMonthlySummary({DateTime? monthAnchor}) {
    final now = DateTime.now();
    final anchor = monthAnchor ?? DateTime(now.year, now.month);
    final monthsAgo = (now.year - anchor.year) * 12 + (now.month - anchor.month);

    // There is no backend, so every month besides the current one is
    // derived from the base seed rather than independently seeded — this
    // is a plausible, deterministic variation, not "real" historical data.
    final factor = (1 - (monthsAgo * 0.08)).clamp(0.55, 1.15);

    final members = _baseMembers
        .map(
          (member) => MonthlySummaryEntry(
            name: member.name,
            totalMeal: (member.totalMeal * factor).round(),
            totalCost: (member.totalCost * factor).roundToDouble(),
            paid: (member.paid * factor).roundToDouble(),
          ),
        )
        .toList();

    return MonthlySummaryResult(
      totalCost: (_baseTotalCost * factor).roundToDouble(),
      totalMeal: (_baseTotalMeal * factor).roundToDouble(),
      members: members,
    );
  }
}
