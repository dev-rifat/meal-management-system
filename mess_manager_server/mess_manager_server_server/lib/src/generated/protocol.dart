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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'mess/models/already_in_a_mess_exception.dart' as _i5;
import 'mess/models/bill_type.dart' as _i6;
import 'mess/models/expense.dart' as _i7;
import 'mess/models/expense_type.dart' as _i8;
import 'mess/models/meal_entry.dart' as _i9;
import 'mess/models/meal_entry_not_found_exception.dart' as _i10;
import 'mess/models/meal_status.dart' as _i11;
import 'mess/models/meal_type.dart' as _i12;
import 'mess/models/member_financial_summary.dart' as _i13;
import 'mess/models/mess.dart' as _i14;
import 'mess/models/mess_financial_summary.dart' as _i15;
import 'mess/models/mess_member.dart' as _i16;
import 'mess/models/mess_member_not_found_exception.dart' as _i17;
import 'mess/models/mess_member_payment_status.dart' as _i18;
import 'mess/models/mess_member_profile.dart' as _i19;
import 'mess/models/mess_member_role.dart' as _i20;
import 'mess/models/mess_not_found_exception.dart' as _i21;
import 'mess/models/monthly_summary_member.dart' as _i22;
import 'mess/models/monthly_summary_result.dart' as _i23;
import 'mess/models/not_mess_manager_exception.dart' as _i24;
import 'mess/models/payment.dart' as _i25;
import 'mess/models/transaction_record.dart' as _i26;
import 'mess/models/transaction_type.dart' as _i27;
import 'package:mess_manager_server_server/src/generated/mess/models/transaction_record.dart'
    as _i28;
import 'package:mess_manager_server_server/src/generated/mess/models/expense.dart'
    as _i29;
import 'package:mess_manager_server_server/src/generated/mess/models/bill_type.dart'
    as _i30;
import 'package:mess_manager_server_server/src/generated/mess/models/meal_entry.dart'
    as _i31;
import 'package:mess_manager_server_server/src/generated/mess/models/mess_member_profile.dart'
    as _i32;
import 'package:mess_manager_server_server/src/generated/mess/models/payment.dart'
    as _i33;
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

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'bill_type',
      dartName: 'BillType',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'bill_type_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bill_type_fk_0',
          columns: ['messId'],
          referenceTable: 'mess',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bill_type_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bill_type_mess_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'messId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'expense',
      dartName: 'Expense',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'expense_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'memberId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExpenseType',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'details',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'billTypeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'expense_fk_0',
          columns: ['messId'],
          referenceTable: 'mess',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'expense_fk_1',
          columns: ['memberId'],
          referenceTable: 'mess_member',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'expense_fk_2',
          columns: ['billTypeId'],
          referenceTable: 'bill_type',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'expense_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'meal_entry',
      dartName: 'MealEntry',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'meal_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'memberId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'mealType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MealType',
        ),
        _i2.ColumnDefinition(
          name: 'mealCount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MealStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_entry_fk_0',
          columns: ['messId'],
          referenceTable: 'mess',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_entry_fk_1',
          columns: ['memberId'],
          referenceTable: 'mess_member',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'meal_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'meal_entry_member_date_type_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'memberId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'date',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'mealType',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'mess',
      dartName: 'Mess',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'mess_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'inviteCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ownerAuthUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'mess_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'mess_invite_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'mess_member',
      dartName: 'MessMember',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'mess_member_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'messId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MessMemberRole',
          columnDefault: '\'member\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'paymentStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MessMemberPaymentStatus',
          columnDefault: '\'due\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'paymentDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'joiningDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'emergencyContact',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'birthday',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'mess_member_fk_0',
          columns: ['messId'],
          referenceTable: 'mess',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'mess_member_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'mess_member_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'payment',
      dartName: 'Payment',
      schema: 'public',
      module: 'mess_manager_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'payment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'memberId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'payment_fk_0',
          columns: ['messId'],
          referenceTable: 'mess',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'payment_fk_1',
          columns: ['memberId'],
          referenceTable: 'mess_member',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'payment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i5.AlreadyInAMessException) {
      return _i5.AlreadyInAMessException.fromJson(data) as T;
    }
    if (t == _i6.BillType) {
      return _i6.BillType.fromJson(data) as T;
    }
    if (t == _i7.Expense) {
      return _i7.Expense.fromJson(data) as T;
    }
    if (t == _i8.ExpenseType) {
      return _i8.ExpenseType.fromJson(data) as T;
    }
    if (t == _i9.MealEntry) {
      return _i9.MealEntry.fromJson(data) as T;
    }
    if (t == _i10.MealEntryNotFoundException) {
      return _i10.MealEntryNotFoundException.fromJson(data) as T;
    }
    if (t == _i11.MealStatus) {
      return _i11.MealStatus.fromJson(data) as T;
    }
    if (t == _i12.MealType) {
      return _i12.MealType.fromJson(data) as T;
    }
    if (t == _i13.MemberFinancialSummary) {
      return _i13.MemberFinancialSummary.fromJson(data) as T;
    }
    if (t == _i14.Mess) {
      return _i14.Mess.fromJson(data) as T;
    }
    if (t == _i15.MessFinancialSummary) {
      return _i15.MessFinancialSummary.fromJson(data) as T;
    }
    if (t == _i16.MessMember) {
      return _i16.MessMember.fromJson(data) as T;
    }
    if (t == _i17.MessMemberNotFoundException) {
      return _i17.MessMemberNotFoundException.fromJson(data) as T;
    }
    if (t == _i18.MessMemberPaymentStatus) {
      return _i18.MessMemberPaymentStatus.fromJson(data) as T;
    }
    if (t == _i19.MessMemberProfile) {
      return _i19.MessMemberProfile.fromJson(data) as T;
    }
    if (t == _i20.MessMemberRole) {
      return _i20.MessMemberRole.fromJson(data) as T;
    }
    if (t == _i21.MessNotFoundException) {
      return _i21.MessNotFoundException.fromJson(data) as T;
    }
    if (t == _i22.MonthlySummaryMember) {
      return _i22.MonthlySummaryMember.fromJson(data) as T;
    }
    if (t == _i23.MonthlySummaryResult) {
      return _i23.MonthlySummaryResult.fromJson(data) as T;
    }
    if (t == _i24.NotMessManagerException) {
      return _i24.NotMessManagerException.fromJson(data) as T;
    }
    if (t == _i25.Payment) {
      return _i25.Payment.fromJson(data) as T;
    }
    if (t == _i26.TransactionRecord) {
      return _i26.TransactionRecord.fromJson(data) as T;
    }
    if (t == _i27.TransactionType) {
      return _i27.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AlreadyInAMessException?>()) {
      return (data != null ? _i5.AlreadyInAMessException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.BillType?>()) {
      return (data != null ? _i6.BillType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Expense?>()) {
      return (data != null ? _i7.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ExpenseType?>()) {
      return (data != null ? _i8.ExpenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.MealEntry?>()) {
      return (data != null ? _i9.MealEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MealEntryNotFoundException?>()) {
      return (data != null
              ? _i10.MealEntryNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.MealStatus?>()) {
      return (data != null ? _i11.MealStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.MealType?>()) {
      return (data != null ? _i12.MealType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.MemberFinancialSummary?>()) {
      return (data != null ? _i13.MemberFinancialSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.Mess?>()) {
      return (data != null ? _i14.Mess.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MessFinancialSummary?>()) {
      return (data != null ? _i15.MessFinancialSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.MessMember?>()) {
      return (data != null ? _i16.MessMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MessMemberNotFoundException?>()) {
      return (data != null
              ? _i17.MessMemberNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.MessMemberPaymentStatus?>()) {
      return (data != null ? _i18.MessMemberPaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.MessMemberProfile?>()) {
      return (data != null ? _i19.MessMemberProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.MessMemberRole?>()) {
      return (data != null ? _i20.MessMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.MessNotFoundException?>()) {
      return (data != null ? _i21.MessNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.MonthlySummaryMember?>()) {
      return (data != null ? _i22.MonthlySummaryMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.MonthlySummaryResult?>()) {
      return (data != null ? _i23.MonthlySummaryResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.NotMessManagerException?>()) {
      return (data != null ? _i24.NotMessManagerException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Payment?>()) {
      return (data != null ? _i25.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.TransactionRecord?>()) {
      return (data != null ? _i26.TransactionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.TransactionType?>()) {
      return (data != null ? _i27.TransactionType.fromJson(data) : null) as T;
    }
    if (t == List<_i22.MonthlySummaryMember>) {
      return (data as List)
              .map((e) => deserialize<_i22.MonthlySummaryMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.TransactionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i28.TransactionRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.Expense>) {
      return (data as List).map((e) => deserialize<_i29.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i30.BillType>) {
      return (data as List).map((e) => deserialize<_i30.BillType>(e)).toList()
          as T;
    }
    if (t == List<_i31.MealEntry>) {
      return (data as List).map((e) => deserialize<_i31.MealEntry>(e)).toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_i32.MessMemberProfile>) {
      return (data as List)
              .map((e) => deserialize<_i32.MessMemberProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.Payment>) {
      return (data as List).map((e) => deserialize<_i33.Payment>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AlreadyInAMessException => 'AlreadyInAMessException',
      _i6.BillType => 'BillType',
      _i7.Expense => 'Expense',
      _i8.ExpenseType => 'ExpenseType',
      _i9.MealEntry => 'MealEntry',
      _i10.MealEntryNotFoundException => 'MealEntryNotFoundException',
      _i11.MealStatus => 'MealStatus',
      _i12.MealType => 'MealType',
      _i13.MemberFinancialSummary => 'MemberFinancialSummary',
      _i14.Mess => 'Mess',
      _i15.MessFinancialSummary => 'MessFinancialSummary',
      _i16.MessMember => 'MessMember',
      _i17.MessMemberNotFoundException => 'MessMemberNotFoundException',
      _i18.MessMemberPaymentStatus => 'MessMemberPaymentStatus',
      _i19.MessMemberProfile => 'MessMemberProfile',
      _i20.MessMemberRole => 'MessMemberRole',
      _i21.MessNotFoundException => 'MessNotFoundException',
      _i22.MonthlySummaryMember => 'MonthlySummaryMember',
      _i23.MonthlySummaryResult => 'MonthlySummaryResult',
      _i24.NotMessManagerException => 'NotMessManagerException',
      _i25.Payment => 'Payment',
      _i26.TransactionRecord => 'TransactionRecord',
      _i27.TransactionType => 'TransactionType',
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
      case _i5.AlreadyInAMessException():
        return 'AlreadyInAMessException';
      case _i6.BillType():
        return 'BillType';
      case _i7.Expense():
        return 'Expense';
      case _i8.ExpenseType():
        return 'ExpenseType';
      case _i9.MealEntry():
        return 'MealEntry';
      case _i10.MealEntryNotFoundException():
        return 'MealEntryNotFoundException';
      case _i11.MealStatus():
        return 'MealStatus';
      case _i12.MealType():
        return 'MealType';
      case _i13.MemberFinancialSummary():
        return 'MemberFinancialSummary';
      case _i14.Mess():
        return 'Mess';
      case _i15.MessFinancialSummary():
        return 'MessFinancialSummary';
      case _i16.MessMember():
        return 'MessMember';
      case _i17.MessMemberNotFoundException():
        return 'MessMemberNotFoundException';
      case _i18.MessMemberPaymentStatus():
        return 'MessMemberPaymentStatus';
      case _i19.MessMemberProfile():
        return 'MessMemberProfile';
      case _i20.MessMemberRole():
        return 'MessMemberRole';
      case _i21.MessNotFoundException():
        return 'MessNotFoundException';
      case _i22.MonthlySummaryMember():
        return 'MonthlySummaryMember';
      case _i23.MonthlySummaryResult():
        return 'MonthlySummaryResult';
      case _i24.NotMessManagerException():
        return 'NotMessManagerException';
      case _i25.Payment():
        return 'Payment';
      case _i26.TransactionRecord():
        return 'TransactionRecord';
      case _i27.TransactionType():
        return 'TransactionType';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
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
      return deserialize<_i5.AlreadyInAMessException>(data['data']);
    }
    if (dataClassName == 'BillType') {
      return deserialize<_i6.BillType>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i7.Expense>(data['data']);
    }
    if (dataClassName == 'ExpenseType') {
      return deserialize<_i8.ExpenseType>(data['data']);
    }
    if (dataClassName == 'MealEntry') {
      return deserialize<_i9.MealEntry>(data['data']);
    }
    if (dataClassName == 'MealEntryNotFoundException') {
      return deserialize<_i10.MealEntryNotFoundException>(data['data']);
    }
    if (dataClassName == 'MealStatus') {
      return deserialize<_i11.MealStatus>(data['data']);
    }
    if (dataClassName == 'MealType') {
      return deserialize<_i12.MealType>(data['data']);
    }
    if (dataClassName == 'MemberFinancialSummary') {
      return deserialize<_i13.MemberFinancialSummary>(data['data']);
    }
    if (dataClassName == 'Mess') {
      return deserialize<_i14.Mess>(data['data']);
    }
    if (dataClassName == 'MessFinancialSummary') {
      return deserialize<_i15.MessFinancialSummary>(data['data']);
    }
    if (dataClassName == 'MessMember') {
      return deserialize<_i16.MessMember>(data['data']);
    }
    if (dataClassName == 'MessMemberNotFoundException') {
      return deserialize<_i17.MessMemberNotFoundException>(data['data']);
    }
    if (dataClassName == 'MessMemberPaymentStatus') {
      return deserialize<_i18.MessMemberPaymentStatus>(data['data']);
    }
    if (dataClassName == 'MessMemberProfile') {
      return deserialize<_i19.MessMemberProfile>(data['data']);
    }
    if (dataClassName == 'MessMemberRole') {
      return deserialize<_i20.MessMemberRole>(data['data']);
    }
    if (dataClassName == 'MessNotFoundException') {
      return deserialize<_i21.MessNotFoundException>(data['data']);
    }
    if (dataClassName == 'MonthlySummaryMember') {
      return deserialize<_i22.MonthlySummaryMember>(data['data']);
    }
    if (dataClassName == 'MonthlySummaryResult') {
      return deserialize<_i23.MonthlySummaryResult>(data['data']);
    }
    if (dataClassName == 'NotMessManagerException') {
      return deserialize<_i24.NotMessManagerException>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i25.Payment>(data['data']);
    }
    if (dataClassName == 'TransactionRecord') {
      return deserialize<_i26.TransactionRecord>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i27.TransactionType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.BillType:
        return _i6.BillType.t;
      case _i7.Expense:
        return _i7.Expense.t;
      case _i9.MealEntry:
        return _i9.MealEntry.t;
      case _i14.Mess:
        return _i14.Mess.t;
      case _i16.MessMember:
        return _i16.MessMember.t;
      case _i25.Payment:
        return _i25.Payment.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'mess_manager_server';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
