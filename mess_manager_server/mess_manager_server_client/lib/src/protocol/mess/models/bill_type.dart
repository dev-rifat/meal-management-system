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
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i3;

/// A named category for shared (non-market) expenses, e.g. "WiFi", "Gas" —
/// scoped to one mess, created on demand when a manager types a new name
/// (see `ExpenseEndpoint.addSharedExpense`).
abstract class BillType implements _i1.SerializableModel {
  BillType._({
    this.id,
    required this.messId,
    this.mess,
    required this.name,
  });

  factory BillType({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required String name,
  }) = _BillTypeImpl;

  factory BillType.fromJson(Map<String, dynamic> jsonSerialization) {
    return BillType(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Mess>(jsonSerialization['mess']),
      name: jsonSerialization['name'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int messId;

  _i2.Mess? mess;

  String name;

  /// Returns a shallow copy of this [BillType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BillType copyWith({
    int? id,
    int? messId,
    _i2.Mess? mess,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BillType',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'name': name,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BillTypeImpl extends BillType {
  _BillTypeImpl({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required String name,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         name: name,
       );

  /// Returns a shallow copy of this [BillType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BillType copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    String? name,
  }) {
    return BillType(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i2.Mess? ? mess : this.mess?.copyWith(),
      name: name ?? this.name,
    );
  }
}
