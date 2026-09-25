/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// The whole mess's deposits/food-expense/meal-rate for a given month —
/// the dashboard's mess-wide balance card. Not a table — built by
/// `DashboardEndpoint.getMessSummary`.
abstract class MessFinancialSummary implements _i1.SerializableModel {
  MessFinancialSummary._({
    required this.deposit,
    required this.expense,
    required this.mealRate,
  });

  factory MessFinancialSummary({
    required double deposit,
    required double expense,
    required double mealRate,
  }) = _MessFinancialSummaryImpl;

  factory MessFinancialSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MessFinancialSummary(
      deposit: (jsonSerialization['deposit'] as num).toDouble(),
      expense: (jsonSerialization['expense'] as num).toDouble(),
      mealRate: (jsonSerialization['mealRate'] as num).toDouble(),
    );
  }

  double deposit;

  double expense;

  double mealRate;

  /// Returns a shallow copy of this [MessFinancialSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessFinancialSummary copyWith({
    double? deposit,
    double? expense,
    double? mealRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessFinancialSummary',
      'deposit': deposit,
      'expense': expense,
      'mealRate': mealRate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MessFinancialSummaryImpl extends MessFinancialSummary {
  _MessFinancialSummaryImpl({
    required double deposit,
    required double expense,
    required double mealRate,
  }) : super._(
         deposit: deposit,
         expense: expense,
         mealRate: mealRate,
       );

  /// Returns a shallow copy of this [MessFinancialSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessFinancialSummary copyWith({
    double? deposit,
    double? expense,
    double? mealRate,
  }) {
    return MessFinancialSummary(
      deposit: deposit ?? this.deposit,
      expense: expense ?? this.expense,
      mealRate: mealRate ?? this.mealRate,
    );
  }
}
