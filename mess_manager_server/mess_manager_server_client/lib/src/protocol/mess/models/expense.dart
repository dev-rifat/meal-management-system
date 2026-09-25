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
import '../../mess/models/expense_type.dart' as _i4;
import '../../mess/models/bill_type.dart' as _i5;
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i6;

/// A market or shared expense, attributed to whichever member a manager
/// recorded it against (`member`) — not necessarily the manager
/// themself. [billType] is only ever set for `type == share`.
abstract class Expense implements _i1.SerializableModel {
  Expense._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.details,
    this.billTypeId,
    this.billType,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Expense({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required String title,
    required double amount,
    required _i4.ExpenseType type,
    required DateTime date,
    required String details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  }) = _ExpenseImpl;

  factory Expense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Expense(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.MessMember>(
              jsonSerialization['member'],
            ),
      title: jsonSerialization['title'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      type: _i4.ExpenseType.fromJson((jsonSerialization['type'] as String)),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      details: jsonSerialization['details'] as String,
      billTypeId: jsonSerialization['billTypeId'] as int?,
      billType: jsonSerialization['billType'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.BillType>(
              jsonSerialization['billType'],
            ),
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

  String title;

  double amount;

  _i4.ExpenseType type;

  DateTime date;

  String details;

  int? billTypeId;

  _i5.BillType? billType;

  DateTime createdAt;

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Expense copyWith({
    int? id,
    int? messId,
    _i2.Mess? mess,
    int? memberId,
    _i3.MessMember? member,
    String? title,
    double? amount,
    _i4.ExpenseType? type,
    DateTime? date,
    String? details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Expense',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'title': title,
      'amount': amount,
      'type': type.toJson(),
      'date': date.toJson(),
      'details': details,
      if (billTypeId != null) 'billTypeId': billTypeId,
      if (billType != null) 'billType': billType?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseImpl extends Expense {
  _ExpenseImpl({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required String title,
    required double amount,
    required _i4.ExpenseType type,
    required DateTime date,
    required String details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         title: title,
         amount: amount,
         type: type,
         date: date,
         details: details,
         billTypeId: billTypeId,
         billType: billType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Expense copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    String? title,
    double? amount,
    _i4.ExpenseType? type,
    DateTime? date,
    String? details,
    Object? billTypeId = _Undefined,
    Object? billType = _Undefined,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i2.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i3.MessMember? ? member : this.member?.copyWith(),
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      details: details ?? this.details,
      billTypeId: billTypeId is int? ? billTypeId : this.billTypeId,
      billType: billType is _i5.BillType?
          ? billType
          : this.billType?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
