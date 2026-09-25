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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _i1;
import '../../mess/models/mess.dart' as _i2;
import '../../mess/models/mess_member.dart' as _i3;
import '../../mess/models/expense_type.dart' as _i4;
import '../../mess/models/bill_type.dart' as _i5;
import 'package:mess_manager_server_server/src/generated/protocol.dart' as _i6;

/// A market or shared expense, attributed to whichever member a manager
/// recorded it against (`member`) — not necessarily the manager
/// themself. [billType] is only ever set for `type == share`.
abstract class Expense
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Expense._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.details,
    this.billTypeId,
    this.billType,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Expense({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required String title,
    required double amount,
    required _i4.ExpenseType type,
    required DateTime date,
    required String details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  }) = _ExpenseImpl;

  factory Expense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Expense(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.MessMember>(
              jsonSerialization['member'],
            ),
      title: jsonSerialization['title'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      type: _i4.ExpenseType.fromJson((jsonSerialization['type'] as String)),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      details: jsonSerialization['details'] as String,
      billTypeId: jsonSerialization['billTypeId'] as int?,
      billType: jsonSerialization['billType'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.BillType>(
              jsonSerialization['billType'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ExpenseTable();

  static const db = ExpenseRepository._();

  @override
  int? id;

  int messId;

  _i2.Mess? mess;

  int memberId;

  _i3.MessMember? member;

  String title;

  double amount;

  _i4.ExpenseType type;

  DateTime date;

  String details;

  int? billTypeId;

  _i5.BillType? billType;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Expense copyWith({
    int? id,
    int? messId,
    _i2.Mess? mess,
    int? memberId,
    _i3.MessMember? member,
    String? title,
    double? amount,
    _i4.ExpenseType? type,
    DateTime? date,
    String? details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Expense',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'title': title,
      'amount': amount,
      'type': type.toJson(),
      'date': date.toJson(),
      'details': details,
      if (billTypeId != null) 'billTypeId': billTypeId,
      if (billType != null) 'billType': billType?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Expense',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJsonForProtocol(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJsonForProtocol(),
      'title': title,
      'amount': amount,
      'type': type.toJson(),
      'date': date.toJson(),
      'details': details,
      if (billTypeId != null) 'billTypeId': billTypeId,
      if (billType != null) 'billType': billType?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ExpenseInclude include({
    _i2.MessInclude? mess,
    _i3.MessMemberInclude? member,
    _i5.BillTypeInclude? billType,
  }) {
    return ExpenseInclude._(
      mess: mess,
      member: member,
      billType: billType,
    );
  }

  static ExpenseIncludeList includeList({
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    ExpenseInclude? include,
  }) {
    return ExpenseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Expense.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Expense.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseImpl extends Expense {
  _ExpenseImpl({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required String title,
    required double amount,
    required _i4.ExpenseType type,
    required DateTime date,
    required String details,
    int? billTypeId,
    _i5.BillType? billType,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         title: title,
         amount: amount,
         type: type,
         date: date,
         details: details,
         billTypeId: billTypeId,
         billType: billType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Expense copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    String? title,
    double? amount,
    _i4.ExpenseType? type,
    DateTime? date,
    String? details,
    Object? billTypeId = _Undefined,
    Object? billType = _Undefined,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i2.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i3.MessMember? ? member : this.member?.copyWith(),
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      details: details ?? this.details,
      billTypeId: billTypeId is int? ? billTypeId : this.billTypeId,
      billType: billType is _i5.BillType?
          ? billType
          : this.billType?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ExpenseUpdateTable extends _i1.UpdateTable<ExpenseTable> {
  ExpenseUpdateTable(super.table);

  _i1.ColumnValue<int, int> messId(int value) => _i1.ColumnValue(
    table.messId,
    value,
  );

  _i1.ColumnValue<int, int> memberId(int value) => _i1.ColumnValue(
    table.memberId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<_i4.ExpenseType, _i4.ExpenseType> type(
    _i4.ExpenseType value,
  ) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<String, String> details(String value) => _i1.ColumnValue(
    table.details,
    value,
  );

  _i1.ColumnValue<int, int> billTypeId(int? value) => _i1.ColumnValue(
    table.billTypeId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ExpenseTable extends _i1.Table<int?> {
  ExpenseTable({super.tableRelation}) : super(tableName: 'expense') {
    updateTable = ExpenseUpdateTable(this);
    messId = _i1.ColumnInt(
      'messId',
      this,
    );
    memberId = _i1.ColumnInt(
      'memberId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    billTypeId = _i1.ColumnInt(
      'billTypeId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ExpenseUpdateTable updateTable;

  late final _i1.ColumnInt messId;

  _i2.MessTable? _mess;

  late final _i1.ColumnInt memberId;

  _i3.MessMemberTable? _member;

  late final _i1.ColumnString title;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnEnum<_i4.ExpenseType> type;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString details;

  late final _i1.ColumnInt billTypeId;

  _i5.BillTypeTable? _billType;

  late final _i1.ColumnDateTime createdAt;

  _i2.MessTable get mess {
    if (_mess != null) return _mess!;
    _mess = _i1.createRelationTable(
      relationFieldName: 'mess',
      field: Expense.t.messId,
      foreignField: _i2.Mess.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MessTable(tableRelation: foreignTableRelation),
    );
    return _mess!;
  }

  _i3.MessMemberTable get member {
    if (_member != null) return _member!;
    _member = _i1.createRelationTable(
      relationFieldName: 'member',
      field: Expense.t.memberId,
      foreignField: _i3.MessMember.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MessMemberTable(tableRelation: foreignTableRelation),
    );
    return _member!;
  }

  _i5.BillTypeTable get billType {
    if (_billType != null) return _billType!;
    _billType = _i1.createRelationTable(
      relationFieldName: 'billType',
      field: Expense.t.billTypeId,
      foreignField: _i5.BillType.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.BillTypeTable(tableRelation: foreignTableRelation),
    );
    return _billType!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    messId,
    memberId,
    title,
    amount,
    type,
    date,
    details,
    billTypeId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'mess') {
      return mess;
    }
    if (relationField == 'member') {
      return member;
    }
    if (relationField == 'billType') {
      return billType;
    }
    return null;
  }
}

class ExpenseInclude extends _i1.IncludeObject {
  ExpenseInclude._({
    _i2.MessInclude? mess,
    _i3.MessMemberInclude? member,
    _i5.BillTypeInclude? billType,
  }) {
    _mess = mess;
    _member = member;
    _billType = billType;
  }

  _i2.MessInclude? _mess;

  _i3.MessMemberInclude? _member;

  _i5.BillTypeInclude? _billType;

  @override
  Map<String, _i1.Include?> get includes => {
    'mess': _mess,
    'member': _member,
    'billType': _billType,
  };

  @override
  _i1.Table<int?> get table => Expense.t;
}

class ExpenseIncludeList extends _i1.IncludeList {
  ExpenseIncludeList._({
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Expense.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Expense.t;
}

class ExpenseRepository {
  const ExpenseRepository._();

  final attachRow = const ExpenseAttachRowRepository._();

  final detachRow = const ExpenseDetachRowRepository._();

  /// Returns a list of [Expense]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Expense>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    _i1.Transaction? transaction,
    ExpenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Expense>(
      where: where?.call(Expense.t),
      orderBy: orderBy?.call(Expense.t),
      orderByList: orderByList?.call(Expense.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Expense] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Expense?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    _i1.Transaction? transaction,
    ExpenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Expense>(
      where: where?.call(Expense.t),
      orderBy: orderBy?.call(Expense.t),
      orderByList: orderByList?.call(Expense.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Expense] by its [id] or null if no such row exists.
  Future<Expense?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ExpenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Expense>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Expense]s in the list and returns the inserted rows.
  ///
  /// The returned [Expense]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Expense>> insert(
    _i1.DatabaseSession session,
    List<Expense> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Expense>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Expense] and returns the inserted row.
  ///
  /// The returned [Expense] will have its `id` field set.
  Future<Expense> insertRow(
    _i1.DatabaseSession session,
    Expense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Expense>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Expense]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Expense>> update(
    _i1.DatabaseSession session,
    List<Expense> rows, {
    _i1.ColumnSelections<ExpenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Expense>(
      rows,
      columns: columns?.call(Expense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Expense]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Expense> updateRow(
    _i1.DatabaseSession session,
    Expense row, {
    _i1.ColumnSelections<ExpenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Expense>(
      row,
      columns: columns?.call(Expense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Expense] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Expense?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ExpenseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Expense>(
      id,
      columnValues: columnValues(Expense.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Expense]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Expense>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ExpenseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExpenseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Expense>(
      columnValues: columnValues(Expense.t.updateTable),
      where: where(Expense.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Expense.t),
      orderByList: orderByList?.call(Expense.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Expense]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Expense>> delete(
    _i1.DatabaseSession session,
    List<Expense> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Expense>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Expense].
  Future<Expense> deleteRow(
    _i1.DatabaseSession session,
    Expense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Expense>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Expense>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExpenseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Expense>(
      where: where(Expense.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Expense>(
      where: where?.call(Expense.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Expense] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExpenseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Expense>(
      where: where(Expense.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ExpenseAttachRowRepository {
  const ExpenseAttachRowRepository._();

  /// Creates a relation between the given [Expense] and [Mess]
  /// by setting the [Expense]'s foreign key `messId` to refer to the [Mess].
  Future<void> mess(
    _i1.DatabaseSession session,
    Expense expense,
    _i2.Mess mess, {
    _i1.Transaction? transaction,
  }) async {
    if (expense.id == null) {
      throw ArgumentError.notNull('expense.id');
    }
    if (mess.id == null) {
      throw ArgumentError.notNull('mess.id');
    }

    var $expense = expense.copyWith(messId: mess.id);
    await session.db.updateRow<Expense>(
      $expense,
      columns: [Expense.t.messId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Expense] and [MessMember]
  /// by setting the [Expense]'s foreign key `memberId` to refer to the [MessMember].
  Future<void> member(
    _i1.DatabaseSession session,
    Expense expense,
    _i3.MessMember member, {
    _i1.Transaction? transaction,
  }) async {
    if (expense.id == null) {
      throw ArgumentError.notNull('expense.id');
    }
    if (member.id == null) {
      throw ArgumentError.notNull('member.id');
    }

    var $expense = expense.copyWith(memberId: member.id);
    await session.db.updateRow<Expense>(
      $expense,
      columns: [Expense.t.memberId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Expense] and [BillType]
  /// by setting the [Expense]'s foreign key `billTypeId` to refer to the [BillType].
  Future<void> billType(
    _i1.DatabaseSession session,
    Expense expense,
    _i5.BillType billType, {
    _i1.Transaction? transaction,
  }) async {
    if (expense.id == null) {
      throw ArgumentError.notNull('expense.id');
    }
    if (billType.id == null) {
      throw ArgumentError.notNull('billType.id');
    }

    var $expense = expense.copyWith(billTypeId: billType.id);
    await session.db.updateRow<Expense>(
      $expense,
      columns: [Expense.t.billTypeId],
      transaction: transaction,
    );
  }
}

class ExpenseDetachRowRepository {
  const ExpenseDetachRowRepository._();

  /// Detaches the relation between this [Expense] and the [BillType] set in `billType`
  /// by setting the [Expense]'s foreign key `billTypeId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> billType(
    _i1.DatabaseSession session,
    Expense expense, {
    _i1.Transaction? transaction,
  }) async {
    if (expense.id == null) {
      throw ArgumentError.notNull('expense.id');
    }

    var $expense = expense.copyWith(billTypeId: null);
    await session.db.updateRow<Expense>(
      $expense,
      columns: [Expense.t.billTypeId],
      transaction: transaction,
    );
  }
}
