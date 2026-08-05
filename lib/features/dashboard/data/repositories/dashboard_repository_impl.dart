import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/core/error/failure.dart';
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
  Future<Result<List<BalanceSummary>>> getBalanceSummaries() async {
    try {
      return ResultSuccess(localDataSource.getBalanceSummaries());
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<BalanceSummary>> getWalletSummary() async {
    try {
      return ResultSuccess(localDataSource.getWalletSummary());
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactions() async {
    try {
      return ResultSuccess(localDataSource.getTransactions());
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<List<MealRecord>>> getMealsForMonth({
    required DateTime month,
    MealStatus? status,
  }) async {
    try {
      return ResultSuccess(localDataSource.getMealsForMonth(month: month, status: status));
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<MealRecord>> updateMealStatus({
    required String id,
    required MealStatus status,
  }) async {
    try {
      return ResultSuccess(localDataSource.updateMealStatus(id: id, status: status));
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Result<MonthlySummaryResult>> getMonthlySummary({DateTimeRange? range}) async {
    try {
      return ResultSuccess(localDataSource.getMonthlySummary(monthAnchor: range?.start));
    } on ServerException catch (e) {
      return ResultError(ServerFailure(e.message));
    }
  }
}
