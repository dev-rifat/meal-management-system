import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show DateTimeRange;
import 'package:mass_management/features/dashboard/domain/entities/monthly_summary_entry.dart';

abstract class MonthlySummaryState extends Equatable {
  const MonthlySummaryState();

  @override
  List<Object?> get props => [];
}

class MonthlySummaryLoading extends MonthlySummaryState {
  const MonthlySummaryLoading();
}

class MonthlySummaryLoaded extends MonthlySummaryState {
  final MonthlySummaryResult summary;
  final String filter;
  final DateTimeRange? range;
  final String searchQuery;
  final List<MonthlySummaryEntry> filteredMembers;

  const MonthlySummaryLoaded({
    required this.summary,
    required this.filter,
    required this.range,
    required this.searchQuery,
    required this.filteredMembers,
  });

  MonthlySummaryLoaded copyWith({
    String? searchQuery,
    List<MonthlySummaryEntry>? filteredMembers,
  }) => MonthlySummaryLoaded(
        summary: summary,
        filter: filter,
        range: range,
        searchQuery: searchQuery ?? this.searchQuery,
        filteredMembers: filteredMembers ?? this.filteredMembers,
      );

  @override
  List<Object?> get props => [summary, filter, range, searchQuery, filteredMembers];
}

class MonthlySummaryError extends MonthlySummaryState {
  final String message;

  const MonthlySummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
