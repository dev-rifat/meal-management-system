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
import '../../mess/models/monthly_summary_member.dart' as _i2;
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i3;

/// A month's mess-wide totals plus the per-member breakdown that make up
/// the monthly summary screen. Not a table — built by
/// `DashboardEndpoint.getMonthlySummary`.
abstract class MonthlySummaryResult implements _i1.SerializableModel {
  MonthlySummaryResult._({
    required this.totalCost,
    required this.totalMeal,
    required this.members,
  });

  factory MonthlySummaryResult({
    required double totalCost,
    required double totalMeal,
    required List<_i2.MonthlySummaryMember> members,
  }) = _MonthlySummaryResultImpl;

  factory MonthlySummaryResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MonthlySummaryResult(
      totalCost: (jsonSerialization['totalCost'] as num).toDouble(),
      totalMeal: (jsonSerialization['totalMeal'] as num).toDouble(),
      members: _i3.Protocol().deserialize<List<_i2.MonthlySummaryMember>>(
        jsonSerialization['members'],
      ),
    );
  }

  double totalCost;

  double totalMeal;

  List<_i2.MonthlySummaryMember> members;

  /// Returns a shallow copy of this [MonthlySummaryResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MonthlySummaryResult copyWith({
    double? totalCost,
    double? totalMeal,
    List<_i2.MonthlySummaryMember>? members,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MonthlySummaryResult',
      'totalCost': totalCost,
      'totalMeal': totalMeal,
      'members': members.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MonthlySummaryResultImpl extends MonthlySummaryResult {
  _MonthlySummaryResultImpl({
    required double totalCost,
    required double totalMeal,
    required List<_i2.MonthlySummaryMember> members,
  }) : super._(
         totalCost: totalCost,
         totalMeal: totalMeal,
         members: members,
       );

  /// Returns a shallow copy of this [MonthlySummaryResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MonthlySummaryResult copyWith({
    double? totalCost,
    double? totalMeal,
    List<_i2.MonthlySummaryMember>? members,
  }) {
    return MonthlySummaryResult(
      totalCost: totalCost ?? this.totalCost,
      totalMeal: totalMeal ?? this.totalMeal,
      members: members ?? this.members.map((e0) => e0.copyWith()).toList(),
    );
  }
}
