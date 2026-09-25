import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';

/// Contract the data layer must fulfil for anything dashboard-related. The
/// presentation layer (via the use cases) only ever talks to this
/// interface — it never knows the data is backed by an in-memory store.
abstract class DashboardRepository {
  /// The mess-wide and personal balance cards shown on the dashboard.
  Future<Result<List<BalanceSummary>>> getBalanceSummaries();

  /// The single balance summary shown at the top of the wallet screen.
  Future<Result<BalanceSummary>> getWalletSummary();

  /// Shared by the dashboard's "Transaction History" section and the
  /// wallet screen's "My Transactions" section.
  Future<Result<List<Transaction>>> getTransactions();

  Future<Result<List<MealRecord>>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  });

  /// Updates every one of [entryIds] to [status] — a whole [MealRecord]
  /// row's worth of underlying server entries, approved/rejected together.
  Future<Result<void>> updateMealStatus({
    required List<String> entryIds,
    required MealStatus status,
  });

  /// Submits (or overwrites) [memberId]'s meal counts for [date] — the
  /// manager's "Add Meal" screen and a member's own self-submission both
  /// go through this (see `manager/presentation/pages/add_meal.dart`).
  Future<Result<void>> submitMeal({
    required String memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  });

  /// `range == null` means "the current month". Otherwise `range.start`
  /// selects which month's figures to return.
  Future<Result<MonthlySummaryResult>> getMonthlySummary({DateTimeRange? range});
}
