import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

/// There is no backend for mess-management data yet — every method here is
/// backed by [DashboardLocalDataSource], an in-memory store seeded with the
/// same demo values the old hardcoded widgets used.
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  const DashboardRepositoryImpl(this.localDataSource);

  @override
  Future<Result<List<BalanceSummary>>> getBalanceSummaries() =>
      guard(() async => localDataSource.getBalanceSummaries());

  @override
  Future<Result<BalanceSummary>> getWalletSummary() =>
      guard(() async => localDataSource.getWalletSummary());

  @override
  Future<Result<List<Transaction>>> getTransactions() =>
      guard(() async => localDataSource.getTransactions());

  @override
  Future<Result<List<MealRecord>>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  }) => guard(
    () async => localDataSource.getMealsForMonth(month: month, status: status),
  );

  @override
  Future<Result<MealRecord>> updateMealStatus({
    required String id,
    required MealStatus status,
  }) => guard(
    () async => localDataSource.updateMealStatus(id: id, status: status),
  );

  @override
  Future<Result<MonthlySummaryResult>> getMonthlySummary({DateTimeRange? range}) =>
      guard(
        () async => localDataSource.getMonthlySummary(monthAnchor: range?.start),
      );
}
