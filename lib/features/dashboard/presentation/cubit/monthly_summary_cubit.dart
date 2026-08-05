import 'package:flutter/material.dart' show DateTimeRange;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_monthly_summary.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/monthly_summary_state.dart';

/// Drives the monthly summary screen. Picking a custom month range now
/// actually changes [GetMonthlySummaryParams.range], which flows through
/// to the repository and back as different totals/members — previously
/// `startMonth`/`endMonth` were captured but never used to recompute
/// anything shown on screen.
class MonthlySummaryCubit extends Cubit<MonthlySummaryState> {
  final GetMonthlySummaryUseCase getMonthlySummary;

  MonthlySummaryCubit({required this.getMonthlySummary}) : super(const MonthlySummaryLoading());

  String _filter = "This Month";
  DateTimeRange? _range;
  String _searchQuery = "";

  Future<void> load() => _fetch();

  Future<void> changeFilter(String filter, {DateTimeRange? range}) {
    _filter = filter;
    _range = filter == "Custom" ? (range ?? _range) : null;
    return _fetch();
  }

  /// Preserves the original substring, case-insensitive name search.
  void search(String query) {
    _searchQuery = query;
    final current = state;
    if (current is MonthlySummaryLoaded) {
      emit(current.copyWith(
        searchQuery: query,
        filteredMembers: _applySearch(current.summary.members, query),
      ));
    }
  }

  Future<void> _fetch() async {
    emit(const MonthlySummaryLoading());
    final result = await getMonthlySummary(GetMonthlySummaryParams(range: _range));
    result.fold(
      (failure) {
        emit(MonthlySummaryError(failure.message));
      },
      (summary) {
        emit(MonthlySummaryLoaded(
          summary: summary,
          filter: _filter,
          range: _range,
          searchQuery: _searchQuery,
          filteredMembers: _applySearch(summary.members, _searchQuery),
        ));
      },
    );
  }

  List<MonthlySummaryEntry> _applySearch(List<MonthlySummaryEntry> members, String query) {
    if (query.isEmpty) return members;
    return members
        .where((member) => member.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
