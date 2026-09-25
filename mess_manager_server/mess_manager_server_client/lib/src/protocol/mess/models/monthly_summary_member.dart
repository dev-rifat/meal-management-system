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

/// One mess member's row within a month's summary. Not a table — built
/// by `DashboardEndpoint.getMonthlySummary`.
abstract class MonthlySummaryMember implements _i1.SerializableModel {
  MonthlySummaryMember._({
    required this.memberId,
    required this.name,
    required this.totalMeal,
    required this.totalCost,
    required this.paid,
  });

  factory MonthlySummaryMember({
    required int memberId,
    required String name,
    required double totalMeal,
    required double totalCost,
    required double paid,
  }) = _MonthlySummaryMemberImpl;

  factory MonthlySummaryMember.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MonthlySummaryMember(
      memberId: jsonSerialization['memberId'] as int,
      name: jsonSerialization['name'] as String,
      totalMeal: (jsonSerialization['totalMeal'] as num).toDouble(),
      totalCost: (jsonSerialization['totalCost'] as num).toDouble(),
      paid: (jsonSerialization['paid'] as num).toDouble(),
    );
  }

  int memberId;

  String name;

  double totalMeal;

  double totalCost;

  double paid;

  /// Returns a shallow copy of this [MonthlySummaryMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MonthlySummaryMember copyWith({
    int? memberId,
    String? name,
    double? totalMeal,
    double? totalCost,
    double? paid,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MonthlySummaryMember',
      'memberId': memberId,
      'name': name,
      'totalMeal': totalMeal,
      'totalCost': totalCost,
      'paid': paid,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MonthlySummaryMemberImpl extends MonthlySummaryMember {
  _MonthlySummaryMemberImpl({
    required int memberId,
    required String name,
    required double totalMeal,
    required double totalCost,
    required double paid,
  }) : super._(
         memberId: memberId,
         name: name,
         totalMeal: totalMeal,
         totalCost: totalCost,
         paid: paid,
       );

  /// Returns a shallow copy of this [MonthlySummaryMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MonthlySummaryMember copyWith({
    int? memberId,
    String? name,
    double? totalMeal,
    double? totalCost,
    double? paid,
  }) {
    return MonthlySummaryMember(
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      totalMeal: totalMeal ?? this.totalMeal,
      totalCost: totalCost ?? this.totalCost,
      paid: paid ?? this.paid,
    );
  }
}
