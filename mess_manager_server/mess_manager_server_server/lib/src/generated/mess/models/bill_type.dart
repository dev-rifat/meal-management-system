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
import 'package:mess_manager_server_server/src/generated/protocol.dart' as _i3;

/// A named category for shared (non-market) expenses, e.g. "WiFi", "Gas" —
/// scoped to one mess, created on demand when a manager types a new name
/// (see `ExpenseEndpoint.addSharedExpense`).
abstract class BillType
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = BillTypeTable();

  static const db = BillTypeRepository._();

  @override
  int? id;

  int messId;

  _i2.Mess? mess;

  String name;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BillType',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJsonForProtocol(),
      'name': name,
    };
  }

  static BillTypeInclude include({_i2.MessInclude? mess}) {
    return BillTypeInclude._(mess: mess);
  }

  static BillTypeIncludeList includeList({
    _i1.WhereExpressionBuilder<BillTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BillTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BillTypeTable>? orderByList,
    BillTypeInclude? include,
  }) {
    return BillTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BillType.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BillType.t),
      include: include,
    );
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

class BillTypeUpdateTable extends _i1.UpdateTable<BillTypeTable> {
  BillTypeUpdateTable(super.table);

  _i1.ColumnValue<int, int> messId(int value) => _i1.ColumnValue(
    table.messId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );
}

class BillTypeTable extends _i1.Table<int?> {
  BillTypeTable({super.tableRelation}) : super(tableName: 'bill_type') {
    updateTable = BillTypeUpdateTable(this);
    messId = _i1.ColumnInt(
      'messId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final BillTypeUpdateTable updateTable;

  late final _i1.ColumnInt messId;

  _i2.MessTable? _mess;

  late final _i1.ColumnString name;

  _i2.MessTable get mess {
    if (_mess != null) return _mess!;
    _mess = _i1.createRelationTable(
      relationFieldName: 'mess',
      field: BillType.t.messId,
      foreignField: _i2.Mess.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MessTable(tableRelation: foreignTableRelation),
    );
    return _mess!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    messId,
    name,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'mess') {
      return mess;
    }
    return null;
  }
}

class BillTypeInclude extends _i1.IncludeObject {
  BillTypeInclude._({_i2.MessInclude? mess}) {
    _mess = mess;
  }

  _i2.MessInclude? _mess;

  @override
  Map<String, _i1.Include?> get includes => {'mess': _mess};

  @override
  _i1.Table<int?> get table => BillType.t;
}

class BillTypeIncludeList extends _i1.IncludeList {
  BillTypeIncludeList._({
    _i1.WhereExpressionBuilder<BillTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BillType.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BillType.t;
}

class BillTypeRepository {
  const BillTypeRepository._();

  final attachRow = const BillTypeAttachRowRepository._();

  /// Returns a list of [BillType]s matching the given query parameters.
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
  Future<List<BillType>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BillTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BillTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BillTypeTable>? orderByList,
    _i1.Transaction? transaction,
    BillTypeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BillType>(
      where: where?.call(BillType.t),
      orderBy: orderBy?.call(BillType.t),
      orderByList: orderByList?.call(BillType.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BillType] matching the given query parameters.
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
  Future<BillType?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BillTypeTable>? where,
    int? offset,
    _i1.OrderByBuilder<BillTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BillTypeTable>? orderByList,
    _i1.Transaction? transaction,
    BillTypeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BillType>(
      where: where?.call(BillType.t),
      orderBy: orderBy?.call(BillType.t),
      orderByList: orderByList?.call(BillType.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BillType] by its [id] or null if no such row exists.
  Future<BillType?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    BillTypeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BillType>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BillType]s in the list and returns the inserted rows.
  ///
  /// The returned [BillType]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BillType>> insert(
    _i1.DatabaseSession session,
    List<BillType> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BillType>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BillType] and returns the inserted row.
  ///
  /// The returned [BillType] will have its `id` field set.
  Future<BillType> insertRow(
    _i1.DatabaseSession session,
    BillType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BillType>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BillType]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BillType>> update(
    _i1.DatabaseSession session,
    List<BillType> rows, {
    _i1.ColumnSelections<BillTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BillType>(
      rows,
      columns: columns?.call(BillType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BillType]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BillType> updateRow(
    _i1.DatabaseSession session,
    BillType row, {
    _i1.ColumnSelections<BillTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BillType>(
      row,
      columns: columns?.call(BillType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BillType] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BillType?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BillTypeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BillType>(
      id,
      columnValues: columnValues(BillType.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BillType]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BillType>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BillTypeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BillTypeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BillTypeTable>? orderBy,
    _i1.OrderByListBuilder<BillTypeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BillType>(
      columnValues: columnValues(BillType.t.updateTable),
      where: where(BillType.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BillType.t),
      orderByList: orderByList?.call(BillType.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BillType]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BillType>> delete(
    _i1.DatabaseSession session,
    List<BillType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BillType>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BillType].
  Future<BillType> deleteRow(
    _i1.DatabaseSession session,
    BillType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BillType>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BillType>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BillTypeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BillType>(
      where: where(BillType.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BillTypeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BillType>(
      where: where?.call(BillType.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BillType] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BillTypeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BillType>(
      where: where(BillType.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BillTypeAttachRowRepository {
  const BillTypeAttachRowRepository._();

  /// Creates a relation between the given [BillType] and [Mess]
  /// by setting the [BillType]'s foreign key `messId` to refer to the [Mess].
  Future<void> mess(
    _i1.DatabaseSession session,
    BillType billType,
    _i2.Mess mess, {
    _i1.Transaction? transaction,
  }) async {
    if (billType.id == null) {
      throw ArgumentError.notNull('billType.id');
    }
    if (mess.id == null) {
      throw ArgumentError.notNull('mess.id');
    }

    var $billType = billType.copyWith(messId: mess.id);
    await session.db.updateRow<BillType>(
      $billType,
      columns: [BillType.t.messId],
      transaction: transaction,
    );
  }
}
