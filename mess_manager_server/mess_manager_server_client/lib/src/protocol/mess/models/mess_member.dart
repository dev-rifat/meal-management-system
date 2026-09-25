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
import '../../mess/models/mess_member_role.dart' as _i2;
import '../../mess/models/mess_member_payment_status.dart' as _i3;
import '../../mess/models/mess.dart' as _i4;
import 'package:mess_manager_server_client/src/protocol/protocol.dart' as _i5;

/// App-specific data for a person within a mess. Serverpod's built-in
/// AuthUser/UserProfile (serverpod_auth_core) already own identity
/// (email/password) and basic profile (name); this model holds only what
/// this app adds on top — phone, role, mess membership, payment status —
/// and links back to that AuthUser by id.
abstract class MessMember implements _i1.SerializableModel {
  MessMember._({
    this.id,
    required this.authUserId,
    required this.messId,
    this.mess,
    _i2.MessMemberRole? role,
    required this.phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    this.paymentDate,
    DateTime? joiningDate,
    this.emergencyContact,
    this.birthday,
  }) : role = role ?? _i2.MessMemberRole.member,
       paymentStatus = paymentStatus ?? _i3.MessMemberPaymentStatus.due,
       joiningDate = joiningDate ?? DateTime.now();

  factory MessMember({
    int? id,
    required _i1.UuidValue authUserId,
    required int messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    required String phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  }) = _MessMemberImpl;

  factory MessMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessMember(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Mess>(jsonSerialization['mess']),
      role: jsonSerialization['role'] == null
          ? null
          : _i2.MessMemberRole.fromJson((jsonSerialization['role'] as String)),
      phone: jsonSerialization['phone'] as String,
      paymentStatus: jsonSerialization['paymentStatus'] == null
          ? null
          : _i3.MessMemberPaymentStatus.fromJson(
              (jsonSerialization['paymentStatus'] as String),
            ),
      paymentDate: jsonSerialization['paymentDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['paymentDate'],
            ),
      joiningDate: jsonSerialization['joiningDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['joiningDate'],
            ),
      emergencyContact: jsonSerialization['emergencyContact'] as String?,
      birthday: jsonSerialization['birthday'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['birthday']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The Serverpod AuthUser id this member is signed in as.
  _i1.UuidValue authUserId;

  int messId;

  /// The mess this member belongs to.
  _i4.Mess? mess;

  _i2.MessMemberRole role;

  String phone;

  _i3.MessMemberPaymentStatus paymentStatus;

  DateTime? paymentDate;

  DateTime joiningDate;

  String? emergencyContact;

  DateTime? birthday;

  /// Returns a shallow copy of this [MessMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessMember copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    int? messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    String? phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessMember',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'role': role.toJson(),
      'phone': phone,
      'paymentStatus': paymentStatus.toJson(),
      if (paymentDate != null) 'paymentDate': paymentDate?.toJson(),
      'joiningDate': joiningDate.toJson(),
      if (emergencyContact != null) 'emergencyContact': emergencyContact,
      if (birthday != null) 'birthday': birthday?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessMemberImpl extends MessMember {
  _MessMemberImpl({
    int? id,
    required _i1.UuidValue authUserId,
    required int messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    required String phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  }) : super._(
         id: id,
         authUserId: authUserId,
         messId: messId,
         mess: mess,
         role: role,
         phone: phone,
         paymentStatus: paymentStatus,
         paymentDate: paymentDate,
         joiningDate: joiningDate,
         emergencyContact: emergencyContact,
         birthday: birthday,
       );

  /// Returns a shallow copy of this [MessMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessMember copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    int? messId,
    Object? mess = _Undefined,
    _i2.MessMemberRole? role,
    String? phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    Object? paymentDate = _Undefined,
    DateTime? joiningDate,
    Object? emergencyContact = _Undefined,
    Object? birthday = _Undefined,
  }) {
    return MessMember(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      messId: messId ?? this.messId,
      mess: mess is _i4.Mess? ? mess : this.mess?.copyWith(),
      role: role ?? this.role,
      phone: phone ?? this.phone,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentDate: paymentDate is DateTime? ? paymentDate : this.paymentDate,
      joiningDate: joiningDate ?? this.joiningDate,
      emergencyContact: emergencyContact is String?
          ? emergencyContact
          : this.emergencyContact,
      birthday: birthday is DateTime? ? birthday : this.birthday,
    );
  }
}
