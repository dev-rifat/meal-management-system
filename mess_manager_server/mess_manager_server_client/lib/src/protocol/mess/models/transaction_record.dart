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
import '../../mess/models/transaction_type.dart' as _i2;

/// One line in a member's own transaction history — a [Payment] they made
/// (`type == deposit`) or an [Expense] they were recorded as the spender
/// of. Not a table — built by `DashboardEndpoint.getTransactions`.
abstract class TransactionRecord implements _i1.SerializableModel {
  TransactionRecord._({
    required this.type,
    required this.amount,
    required this.date,
    this.label,
  });

  factory TransactionRecord({
    required _i2.TransactionType type,
    required double amount,
    required DateTime date,
    String? label,
  }) = _TransactionRecordImpl;

  factory TransactionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return TransactionRecord(
      type: _i2.TransactionType.fromJson((jsonSerialization['type'] as String)),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      label: jsonSerialization['label'] as String?,
    );
  }

  _i2.TransactionType type;

  double amount;

  DateTime date;

  /// The expense's title (market) or bill type name (share) — null for a
  /// deposit, which has no title of its own.
  String? label;

  /// Returns a shallow copy of this [TransactionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TransactionRecord copyWith({
    _i2.TransactionType? type,
    double? amount,
    DateTime? date,
    String? label,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TransactionRecord',
      'type': type.toJson(),
      'amount': amount,
      'date': date.toJson(),
      if (label != null) 'label': label,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransactionRecordImpl extends TransactionRecord {
  _TransactionRecordImpl({
    required _i2.TransactionType type,
    required double amount,
    required DateTime date,
    String? label,
  }) : super._(
         type: type,
         amount: amount,
         date: date,
         label: label,
       );

  /// Returns a shallow copy of this [TransactionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TransactionRecord copyWith({
    _i2.TransactionType? type,
    double? amount,
    DateTime? date,
    Object? label = _Undefined,
  }) {
    return TransactionRecord(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      label: label is String? ? label : this.label,
    );
  }
}
