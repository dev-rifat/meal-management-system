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
import 'mess/models/already_in_a_mess_exception.dart' as _i2;
import 'mess/models/bill_type.dart' as _i3;
import 'mess/models/expense.dart' as _i4;
import 'mess/models/expense_type.dart' as _i5;
import 'mess/models/meal_entry.dart' as _i6;
import 'mess/models/meal_entry_not_found_exception.dart' as _i7;
import 'mess/models/meal_status.dart' as _i8;
import 'mess/models/meal_type.dart' as _i9;
import 'mess/models/member_financial_summary.dart' as _i10;
import 'mess/models/mess.dart' as _i11;
import 'mess/models/mess_financial_summary.dart' as _i12;
import 'mess/models/mess_member.dart' as _i13;
import 'mess/models/mess_member_not_found_exception.dart' as _i14;
import 'mess/models/mess_member_payment_status.dart' as _i15;
import 'mess/models/mess_member_profile.dart' as _i16;
import 'mess/models/mess_member_role.dart' as _i17;
import 'mess/models/mess_not_found_exception.dart' as _i18;
import 'mess/models/monthly_summary_member.dart' as _i19;
import 'mess/models/monthly_summary_result.dart' as _i20;
import 'mess/models/not_mess_manager_exception.dart' as _i21;
import 'mess/models/payment.dart' as _i22;
import 'mess/models/transaction_record.dart' as _i23;
import 'mess/models/transaction_type.dart' as _i24;
import 'package:mess_manager_server_client/src/protocol/mess/models/transaction_record.dart'
    as _i25;
import 'package:mess_manager_server_client/src/protocol/mess/models/expense.dart'
    as _i26;
import 'package:mess_manager_server_client/src/protocol/mess/models/bill_type.dart'
    as _i27;
import 'package:mess_manager_server_client/src/protocol/mess/models/meal_entry.dart'
    as _i28;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess_member_profile.dart'
    as _i29;
import 'package:mess_manager_server_client/src/protocol/mess/models/payment.dart'
    as _i30;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i31;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i32;
export 'mess/models/already_in_a_mess_exception.dart';
export 'mess/models/bill_type.dart';
export 'mess/models/expense.dart';
export 'mess/models/expense_type.dart';
export 'mess/models/meal_entry.dart';
export 'mess/models/meal_entry_not_found_exception.dart';
export 'mess/models/meal_status.dart';
export 'mess/models/meal_type.dart';
export 'mess/models/member_financial_summary.dart';
export 'mess/models/mess.dart';
export 'mess/models/mess_financial_summary.dart';
export 'mess/models/mess_member.dart';
export 'mess/models/mess_member_not_found_exception.dart';
export 'mess/models/mess_member_payment_status.dart';
export 'mess/models/mess_member_profile.dart';
export 'mess/models/mess_member_role.dart';
export 'mess/models/mess_not_found_exception.dart';
export 'mess/models/monthly_summary_member.dart';
export 'mess/models/monthly_summary_result.dart';
export 'mess/models/not_mess_manager_exception.dart';
export 'mess/models/payment.dart';
export 'mess/models/transaction_record.dart';
export 'mess/models/transaction_type.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AlreadyInAMessException) {
      return _i2.AlreadyInAMessException.fromJson(data) as T;
    }
    if (t == _i3.BillType) {
      return _i3.BillType.fromJson(data) as T;
    }
    if (t == _i4.Expense) {
      return _i4.Expense.fromJson(data) as T;
    }
    if (t == _i5.ExpenseType) {
      return _i5.ExpenseType.fromJson(data) as T;
    }
    if (t == _i6.MealEntry) {
      return _i6.MealEntry.fromJson(data) as T;
    }
    if (t == _i7.MealEntryNotFoundException) {
      return _i7.MealEntryNotFoundException.fromJson(data) as T;
    }
    if (t == _i8.MealStatus) {
      return _i8.MealStatus.fromJson(data) as T;
    }
    if (t == _i9.MealType) {
      return _i9.MealType.fromJson(data) as T;
    }
    if (t == _i10.MemberFinancialSummary) {
      return _i10.MemberFinancialSummary.fromJson(data) as T;
    }
    if (t == _i11.Mess) {
      return _i11.Mess.fromJson(data) as T;
    }
    if (t == _i12.MessFinancialSummary) {
      return _i12.MessFinancialSummary.fromJson(data) as T;
    }
    if (t == _i13.MessMember) {
      return _i13.MessMember.fromJson(data) as T;
    }
    if (t == _i14.MessMemberNotFoundException) {
      return _i14.MessMemberNotFoundException.fromJson(data) as T;
    }
    if (t == _i15.MessMemberPaymentStatus) {
      return _i15.MessMemberPaymentStatus.fromJson(data) as T;
    }
    if (t == _i16.MessMemberProfile) {
      return _i16.MessMemberProfile.fromJson(data) as T;
    }
    if (t == _i17.MessMemberRole) {
      return _i17.MessMemberRole.fromJson(data) as T;
    }
    if (t == _i18.MessNotFoundException) {
      return _i18.MessNotFoundException.fromJson(data) as T;
    }
    if (t == _i19.MonthlySummaryMember) {
      return _i19.MonthlySummaryMember.fromJson(data) as T;
    }
    if (t == _i20.MonthlySummaryResult) {
      return _i20.MonthlySummaryResult.fromJson(data) as T;
    }
    if (t == _i21.NotMessManagerException) {
      return _i21.NotMessManagerException.fromJson(data) as T;
    }
    if (t == _i22.Payment) {
      return _i22.Payment.fromJson(data) as T;
    }
    if (t == _i23.TransactionRecord) {
      return _i23.TransactionRecord.fromJson(data) as T;
    }
    if (t == _i24.TransactionType) {
      return _i24.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AlreadyInAMessException?>()) {
      return (data != null ? _i2.AlreadyInAMessException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.BillType?>()) {
      return (data != null ? _i3.BillType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Expense?>()) {
      return (data != null ? _i4.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ExpenseType?>()) {
      return (data != null ? _i5.ExpenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.MealEntry?>()) {
      return (data != null ? _i6.MealEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.MealEntryNotFoundException?>()) {
      return (data != null
              ? _i7.MealEntryNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i8.MealStatus?>()) {
      return (data != null ? _i8.MealStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.MealType?>()) {
      return (data != null ? _i9.MealType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MemberFinancialSummary?>()) {
      return (data != null ? _i10.MemberFinancialSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Mess?>()) {
      return (data != null ? _i11.Mess.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.MessFinancialSummary?>()) {
      return (data != null ? _i12.MessFinancialSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.MessMember?>()) {
      return (data != null ? _i13.MessMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.MessMemberNotFoundException?>()) {
      return (data != null
              ? _i14.MessMemberNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.MessMemberPaymentStatus?>()) {
      return (data != null ? _i15.MessMemberPaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.MessMemberProfile?>()) {
      return (data != null ? _i16.MessMemberProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MessMemberRole?>()) {
      return (data != null ? _i17.MessMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.MessNotFoundException?>()) {
      return (data != null ? _i18.MessNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.MonthlySummaryMember?>()) {
      return (data != null ? _i19.MonthlySummaryMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.MonthlySummaryResult?>()) {
      return (data != null ? _i20.MonthlySummaryResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.NotMessManagerException?>()) {
      return (data != null ? _i21.NotMessManagerException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.Payment?>()) {
      return (data != null ? _i22.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.TransactionRecord?>()) {
      return (data != null ? _i23.TransactionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TransactionType?>()) {
      return (data != null ? _i24.TransactionType.fromJson(data) : null) as T;
    }
    if (t == List<_i19.MonthlySummaryMember>) {
      return (data as List)
              .map((e) => deserialize<_i19.MonthlySummaryMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.TransactionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i25.TransactionRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.Expense>) {
      return (data as List).map((e) => deserialize<_i26.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i27.BillType>) {
      return (data as List).map((e) => deserialize<_i27.BillType>(e)).toList()
          as T;
    }
    if (t == List<_i28.MealEntry>) {
      return (data as List).map((e) => deserialize<_i28.MealEntry>(e)).toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_i29.MessMemberProfile>) {
      return (data as List)
              .map((e) => deserialize<_i29.MessMemberProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.Payment>) {
      return (data as List).map((e) => deserialize<_i30.Payment>(e)).toList()
          as T;
    }
    try {
      return _i31.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i32.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AlreadyInAMessException => 'AlreadyInAMessException',
      _i3.BillType => 'BillType',
      _i4.Expense => 'Expense',
      _i5.ExpenseType => 'ExpenseType',
      _i6.MealEntry => 'MealEntry',
      _i7.MealEntryNotFoundException => 'MealEntryNotFoundException',
      _i8.MealStatus => 'MealStatus',
      _i9.MealType => 'MealType',
      _i10.MemberFinancialSummary => 'MemberFinancialSummary',
      _i11.Mess => 'Mess',
      _i12.MessFinancialSummary => 'MessFinancialSummary',
      _i13.MessMember => 'MessMember',
      _i14.MessMemberNotFoundException => 'MessMemberNotFoundException',
      _i15.MessMemberPaymentStatus => 'MessMemberPaymentStatus',
      _i16.MessMemberProfile => 'MessMemberProfile',
      _i17.MessMemberRole => 'MessMemberRole',
      _i18.MessNotFoundException => 'MessNotFoundException',
      _i19.MonthlySummaryMember => 'MonthlySummaryMember',
      _i20.MonthlySummaryResult => 'MonthlySummaryResult',
      _i21.NotMessManagerException => 'NotMessManagerException',
      _i22.Payment => 'Payment',
      _i23.TransactionRecord => 'TransactionRecord',
      _i24.TransactionType => 'TransactionType',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'mess_manager_server.',
        '',
      );
    }

    switch (data) {
      case _i2.AlreadyInAMessException():
        return 'AlreadyInAMessException';
      case _i3.BillType():
        return 'BillType';
      case _i4.Expense():
        return 'Expense';
      case _i5.ExpenseType():
        return 'ExpenseType';
      case _i6.MealEntry():
        return 'MealEntry';
      case _i7.MealEntryNotFoundException():
        return 'MealEntryNotFoundException';
      case _i8.MealStatus():
        return 'MealStatus';
      case _i9.MealType():
        return 'MealType';
      case _i10.MemberFinancialSummary():
        return 'MemberFinancialSummary';
      case _i11.Mess():
        return 'Mess';
      case _i12.MessFinancialSummary():
        return 'MessFinancialSummary';
      case _i13.MessMember():
        return 'MessMember';
      case _i14.MessMemberNotFoundException():
        return 'MessMemberNotFoundException';
      case _i15.MessMemberPaymentStatus():
        return 'MessMemberPaymentStatus';
      case _i16.MessMemberProfile():
        return 'MessMemberProfile';
      case _i17.MessMemberRole():
        return 'MessMemberRole';
      case _i18.MessNotFoundException():
        return 'MessNotFoundException';
      case _i19.MonthlySummaryMember():
        return 'MonthlySummaryMember';
      case _i20.MonthlySummaryResult():
        return 'MonthlySummaryResult';
      case _i21.NotMessManagerException():
        return 'NotMessManagerException';
      case _i22.Payment():
        return 'Payment';
      case _i23.TransactionRecord():
        return 'TransactionRecord';
      case _i24.TransactionType():
        return 'TransactionType';
    }
    className = _i31.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i32.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AlreadyInAMessException') {
      return deserialize<_i2.AlreadyInAMessException>(data['data']);
    }
    if (dataClassName == 'BillType') {
      return deserialize<_i3.BillType>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i4.Expense>(data['data']);
    }
    if (dataClassName == 'ExpenseType') {
      return deserialize<_i5.ExpenseType>(data['data']);
    }
    if (dataClassName == 'MealEntry') {
      return deserialize<_i6.MealEntry>(data['data']);
    }
    if (dataClassName == 'MealEntryNotFoundException') {
      return deserialize<_i7.MealEntryNotFoundException>(data['data']);
    }
    if (dataClassName == 'MealStatus') {
      return deserialize<_i8.MealStatus>(data['data']);
    }
    if (dataClassName == 'MealType') {
      return deserialize<_i9.MealType>(data['data']);
    }
    if (dataClassName == 'MemberFinancialSummary') {
      return deserialize<_i10.MemberFinancialSummary>(data['data']);
    }
    if (dataClassName == 'Mess') {
      return deserialize<_i11.Mess>(data['data']);
    }
    if (dataClassName == 'MessFinancialSummary') {
      return deserialize<_i12.MessFinancialSummary>(data['data']);
    }
    if (dataClassName == 'MessMember') {
      return deserialize<_i13.MessMember>(data['data']);
    }
    if (dataClassName == 'MessMemberNotFoundException') {
      return deserialize<_i14.MessMemberNotFoundException>(data['data']);
    }
    if (dataClassName == 'MessMemberPaymentStatus') {
      return deserialize<_i15.MessMemberPaymentStatus>(data['data']);
    }
    if (dataClassName == 'MessMemberProfile') {
      return deserialize<_i16.MessMemberProfile>(data['data']);
    }
    if (dataClassName == 'MessMemberRole') {
      return deserialize<_i17.MessMemberRole>(data['data']);
    }
    if (dataClassName == 'MessNotFoundException') {
      return deserialize<_i18.MessNotFoundException>(data['data']);
    }
    if (dataClassName == 'MonthlySummaryMember') {
      return deserialize<_i19.MonthlySummaryMember>(data['data']);
    }
    if (dataClassName == 'MonthlySummaryResult') {
      return deserialize<_i20.MonthlySummaryResult>(data['data']);
    }
    if (dataClassName == 'NotMessManagerException') {
      return deserialize<_i21.NotMessManagerException>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i22.Payment>(data['data']);
    }
    if (dataClassName == 'TransactionRecord') {
      return deserialize<_i23.TransactionRecord>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i24.TransactionType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i31.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i32.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i31.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i32.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
