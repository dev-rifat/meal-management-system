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

/// Thrown when a `MealEndpoint.updateStatus` call targets an id that
/// doesn't exist in the caller's mess.
abstract class MealEntryNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  MealEntryNotFoundException._();

  factory MealEntryNotFoundException() = _MealEntryNotFoundExceptionImpl;

  factory MealEntryNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MealEntryNotFoundException();
  }

  /// Returns a shallow copy of this [MealEntryNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealEntryNotFoundException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'MealEntryNotFoundException'};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'__className__': 'MealEntryNotFoundException'};
  }

  @override
  String toString() {
    return 'MealEntryNotFoundException';
  }
}

class _MealEntryNotFoundExceptionImpl extends MealEntryNotFoundException {
  _MealEntryNotFoundExceptionImpl() : super._();

  /// Returns a shallow copy of this [MealEntryNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealEntryNotFoundException copyWith() {
    return MealEntryNotFoundException();
  }
}
