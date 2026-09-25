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

/// Thrown by [MessEndpoint.join] when no mess matches the given invite code.
abstract class MessNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  MessNotFoundException._();

  factory MessNotFoundException() = _MessNotFoundExceptionImpl;

  factory MessNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MessNotFoundException();
  }

  /// Returns a shallow copy of this [MessNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessNotFoundException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'MessNotFoundException'};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'__className__': 'MessNotFoundException'};
  }

  @override
  String toString() {
    return 'MessNotFoundException';
  }
}

class _MessNotFoundExceptionImpl extends MessNotFoundException {
  _MessNotFoundExceptionImpl() : super._();

  /// Returns a shallow copy of this [MessNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessNotFoundException copyWith() {
    return MessNotFoundException();
  }
}
