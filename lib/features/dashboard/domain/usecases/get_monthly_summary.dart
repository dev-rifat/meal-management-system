import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetMonthlySummaryParams extends Equatable {
  final DateTimeRange? range;

  const GetMonthlySummaryParams({this.range});

  @override
  List<Object?> get props => [range];
}

class GetMonthlySummaryUseCase implements UseCase<MonthlySummaryResult, GetMonthlySummaryParams> {
  final DashboardRepository repository;

  const GetMonthlySummaryUseCase(this.repository);

  @override
  Future<Result<MonthlySummaryResult>> call(GetMonthlySummaryParams params) {
    return repository.getMonthlySummary(range: params.range);
  }
}
