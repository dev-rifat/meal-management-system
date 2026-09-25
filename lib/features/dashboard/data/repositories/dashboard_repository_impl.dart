import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mass_management/features/dashboard/domain/entities/balance_summary.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/entities/transaction.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  const DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<BalanceSummary>>> getBalanceSummaries() =>
      guard(() => remoteDataSource.getBalanceSummaries());

  @override
  Future<Result<BalanceSummary>> getWalletSummary() =>
      guard(() => remoteDataSource.getWalletSummary());

  @override
  Future<Result<List<Transaction>>> getTransactions() =>
      guard(() => remoteDataSource.getTransactions());

  @override
  Future<Result<List<MealRecord>>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  }) => guard(
    () => remoteDataSource.getMealsForMonth(month: month, status: status),
  );

  @override
  Future<Result<void>> updateMealStatus({
    required List<String> entryIds,
    required MealStatus status,
  }) => guard(
    () => remoteDataSource.updateMealStatus(entryIds: entryIds, status: status),
  );

  @override
  Future<Result<void>> submitMeal({
    required String memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  }) => guard(
    () => remoteDataSource.submit(
      memberId: memberId,
      date: date,
      mealCounts: mealCounts,
    ),
  );

  @override
  Future<Result<MonthlySummaryResult>> getMonthlySummary({DateTimeRange? range}) =>
      guard(() => remoteDataSource.getMonthlySummary(monthAnchor: range?.start));
}
