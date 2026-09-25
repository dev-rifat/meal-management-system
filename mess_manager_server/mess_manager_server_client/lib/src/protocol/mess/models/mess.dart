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

/// A shared mess/hostel — the tenant every member, meal, and expense
/// belongs to. Created by whoever taps "Create a Mess"; everyone else joins
/// with [inviteCode].
abstract class Mess implements _i1.SerializableModel {
  Mess._({
    this.id,
    required this.name,
    required this.inviteCode,
    required this.ownerAuthUserId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Mess({
    int? id,
    required String name,
    required String inviteCode,
    required _i1.UuidValue ownerAuthUserId,
    DateTime? createdAt,
  }) = _MessImpl;

  factory Mess.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mess(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      ownerAuthUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerAuthUserId'],
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

  /// Human-readable name, e.g. "Sunshine Mess".
  String name;

  /// Code members use to join — unique, generated server-side.
  String inviteCode;

  /// The AuthUser id of whoever created this mess (its first manager).
  _i1.UuidValue ownerAuthUserId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Mess]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Mess copyWith({
    int? id,
    String? name,
    String? inviteCode,
    _i1.UuidValue? ownerAuthUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mess',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerAuthUserId': ownerAuthUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessImpl extends Mess {
  _MessImpl({
    int? id,
    required String name,
    required String inviteCode,
    required _i1.UuidValue ownerAuthUserId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         inviteCode: inviteCode,
         ownerAuthUserId: ownerAuthUserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Mess]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Mess copyWith({
    Object? id = _Undefined,
    String? name,
    String? inviteCode,
    _i1.UuidValue? ownerAuthUserId,
    DateTime? createdAt,
  }) {
    return Mess(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      ownerAuthUserId: ownerAuthUserId ?? this.ownerAuthUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
