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
import '../../mess/models/meal_status.dart' as _i2;
import '../../mess/models/mess.dart' as _i3;
import '../../mess/models/mess_member.dart' as _i4;
import '../../mess/models/meal_type.dart' as _i5;
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i6;

/// One member's meal count for one day and meal type — e.g. "Jane, 2026-01-05,
/// lunch, 1.0". Replaces two disconnected mock concepts (a per-day,
/// ownerless `MealRecord` with a status, and a per-member `ManagerMealEntry`
/// with no status/read path) with one real, per-entry model: a member (or
/// their manager) submits it, a manager approves/rejects it.
abstract class MealEntry implements _i1.SerializableModel {
  MealEntry._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.date,
    required this.mealType,
    required this.mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.MealStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory MealEntry({
    int? id,
    required int messId,
    _i3.Mess? mess,
    required int memberId,
    _i4.MessMember? member,
    required DateTime date,
    required _i5.MealType mealType,
    required double mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) = _MealEntryImpl;

  factory MealEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealEntry(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.MessMember>(
              jsonSerialization['member'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealType: _i5.MealType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      mealCount: (jsonSerialization['mealCount'] as num).toDouble(),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.MealStatus.fromJson((jsonSerialization['status'] as String)),
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

  _i3.Mess? mess;

  int memberId;

  _i4.MessMember? member;

  DateTime date;

  _i5.MealType mealType;

  double mealCount;

  _i2.MealStatus status;

  DateTime createdAt;

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealEntry copyWith({
    int? id,
    int? messId,
    _i3.Mess? mess,
    int? memberId,
    _i4.MessMember? member,
    DateTime? date,
    _i5.MealType? mealType,
    double? mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealEntry',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      'mealCount': mealCount,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealEntryImpl extends MealEntry {
  _MealEntryImpl({
    int? id,
    required int messId,
    _i3.Mess? mess,
    required int memberId,
    _i4.MessMember? member,
    required DateTime date,
    required _i5.MealType mealType,
    required double mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         date: date,
         mealType: mealType,
         mealCount: mealCount,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealEntry copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    DateTime? date,
    _i5.MealType? mealType,
    double? mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) {
    return MealEntry(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i3.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i4.MessMember? ? member : this.member?.copyWith(),
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      mealCount: mealCount ?? this.mealCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
