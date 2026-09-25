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

import 'package:serverpod/serverpod.dart' as _i1;

/// Thrown when a non-manager calls a manager-only `MessEndpoint` method
/// (e.g. updating another member's payment status, or removing a member).
abstract class NotMessManagerException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  NotMessManagerException._();

  factory NotMessManagerException() = _NotMessManagerExceptionImpl;

  factory NotMessManagerException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotMessManagerException();
  }

  /// Returns a shallow copy of this [NotMessManagerException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotMessManagerException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'NotMessManagerException'};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'__className__': 'NotMessManagerException'};
  }

  @override
  String toString() {
    return 'NotMessManagerException';
  }
}

class _NotMessManagerExceptionImpl extends NotMessManagerException {
  _NotMessManagerExceptionImpl() : super._();

  /// Returns a shallow copy of this [NotMessManagerException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotMessManagerException copyWith() {
    return NotMessManagerException();
  }
}
