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
import '../../mess/models/mess.dart' as _i2;
import '../../mess/models/mess_member.dart' as _i3;
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i4;

/// A deposit a member has paid into the mess — the credit side of their
/// balance (their [Expense] rows are the debit side). Recorded by a
/// manager, e.g. after collecting cash from a member.
abstract class Payment implements _i1.SerializableModel {
  Payment._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.amount,
    required this.date,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Payment({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required double amount,
    required DateTime date,
    DateTime? createdAt,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.MessMember>(
              jsonSerialization['member'],
            ),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int messId;

  _i2.Mess? mess;

  int memberId;

  _i3.MessMember? member;

  double amount;

  DateTime date;

  DateTime createdAt;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? messId,
    _i2.Mess? mess,
    int? memberId,
    _i3.MessMember? member,
    double? amount,
    DateTime? date,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required double amount,
    required DateTime date,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         amount: amount,
         date: date,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    double? amount,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i2.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i3.MessMember? ? member : this.member?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
