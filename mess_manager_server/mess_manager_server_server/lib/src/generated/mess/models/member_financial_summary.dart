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

import 'package:serverpod/serverpod.dart' as _i1;

/// The caller's own all-time financial position — their total deposits
/// vs. their total recorded expenses, plus the mess's overall (all-time)
/// meal rate for reference. Not a table — built by
/// `DashboardEndpoint.getMemberSummary`.
abstract class MemberFinancialSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MemberFinancialSummary._({
    required this.deposit,
    required this.expense,
    required this.balance,
    required this.mealRate,
  });

  factory MemberFinancialSummary({
    required double deposit,
    required double expense,
    required double balance,
    required double mealRate,
  }) = _MemberFinancialSummaryImpl;

  factory MemberFinancialSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MemberFinancialSummary(
      deposit: (jsonSerialization['deposit'] as num).toDouble(),
      expense: (jsonSerialization['expense'] as num).toDouble(),
      balance: (jsonSerialization['balance'] as num).toDouble(),
      mealRate: (jsonSerialization['mealRate'] as num).toDouble(),
    );
  }

  double deposit;

  double expense;

  double balance;

  double mealRate;

  /// Returns a shallow copy of this [MemberFinancialSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MemberFinancialSummary copyWith({
    double? deposit,
    double? expense,
    double? balance,
    double? mealRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberFinancialSummary',
      'deposit': deposit,
      'expense': expense,
      'balance': balance,
      'mealRate': mealRate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberFinancialSummary',
      'deposit': deposit,
      'expense': expense,
      'balance': balance,
      'mealRate': mealRate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MemberFinancialSummaryImpl extends MemberFinancialSummary {
  _MemberFinancialSummaryImpl({
    required double deposit,
    required double expense,
    required double balance,
    required double mealRate,
  }) : super._(
         deposit: deposit,
         expense: expense,
         balance: balance,
         mealRate: mealRate,
       );

  /// Returns a shallow copy of this [MemberFinancialSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MemberFinancialSummary copyWith({
    double? deposit,
    double? expense,
    double? balance,
    double? mealRate,
  }) {
    return MemberFinancialSummary(
      deposit: deposit ?? this.deposit,
      expense: expense ?? this.expense,
      balance: balance ?? this.balance,
      mealRate: mealRate ?? this.mealRate,
    );
  }
}
