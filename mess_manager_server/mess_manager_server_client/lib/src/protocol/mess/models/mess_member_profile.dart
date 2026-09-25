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

/// A member row for the Flutter app's member list — combines [MessMember]
/// (this app's own fields) with Serverpod's built-in [UserProfile]
/// (name/email), since the client needs both together. Not a table — a
/// transfer object built by `MessEndpoint.members`.
abstract class MessMemberProfile implements _i1.SerializableModel {
  MessMemberProfile._({
    required this.id,
    required this.authUserId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.paymentStatus,
    this.paymentDate,
    required this.joiningDate,
    this.profileImageUrl,
  });

  factory MessMemberProfile({
    required int id,
    required _i1.UuidValue authUserId,
    required String name,
    required String email,
    required String phone,
    required _i2.MessMemberRole role,
    required _i3.MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
    required DateTime joiningDate,
    String? profileImageUrl,
  }) = _MessMemberProfileImpl;

  factory MessMemberProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessMemberProfile(
      id: jsonSerialization['id'] as int,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      phone: jsonSerialization['phone'] as String,
      role: _i2.MessMemberRole.fromJson((jsonSerialization['role'] as String)),
      paymentStatus: _i3.MessMemberPaymentStatus.fromJson(
        (jsonSerialization['paymentStatus'] as String),
      ),
      paymentDate: jsonSerialization['paymentDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['paymentDate'],
            ),
      joiningDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joiningDate'],
      ),
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
    );
  }

  int id;

  _i1.UuidValue authUserId;

  String name;

  String email;

  String phone;

  _i2.MessMemberRole role;

  _i3.MessMemberPaymentStatus paymentStatus;

  DateTime? paymentDate;

  DateTime joiningDate;

  String? profileImageUrl;

  /// Returns a shallow copy of this [MessMemberProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessMemberProfile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? name,
    String? email,
    String? phone,
    _i2.MessMemberRole? role,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? profileImageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessMemberProfile',
      'id': id,
      'authUserId': authUserId.toJson(),
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toJson(),
      'paymentStatus': paymentStatus.toJson(),
      if (paymentDate != null) 'paymentDate': paymentDate?.toJson(),
      'joiningDate': joiningDate.toJson(),
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessMemberProfileImpl extends MessMemberProfile {
  _MessMemberProfileImpl({
    required int id,
    required _i1.UuidValue authUserId,
    required String name,
    required String email,
    required String phone,
    required _i2.MessMemberRole role,
    required _i3.MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
    required DateTime joiningDate,
    String? profileImageUrl,
  }) : super._(
         id: id,
         authUserId: authUserId,
         name: name,
         email: email,
         phone: phone,
         role: role,
         paymentStatus: paymentStatus,
         paymentDate: paymentDate,
         joiningDate: joiningDate,
         profileImageUrl: profileImageUrl,
       );

  /// Returns a shallow copy of this [MessMemberProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessMemberProfile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? name,
    String? email,
    String? phone,
    _i2.MessMemberRole? role,
    _i3.MessMemberPaymentStatus? paymentStatus,
    Object? paymentDate = _Undefined,
    DateTime? joiningDate,
    Object? profileImageUrl = _Undefined,
  }) {
    return MessMemberProfile(
      id: id ?? this.id,
      authUserId: authUserId ?? this.authUserId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentDate: paymentDate is DateTime? ? paymentDate : this.paymentDate,
      joiningDate: joiningDate ?? this.joiningDate,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
    );
  }
}
