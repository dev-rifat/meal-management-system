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

/// A shared mess/hostel — the tenant every member, meal, and expense
/// belongs to. Created by whoever taps "Create a Mess"; everyone else joins
/// with [inviteCode].
abstract class Mess implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MessTable();

  static const db = MessRepository._();

  @override
  int? id;

  /// Human-readable name, e.g. "Sunshine Mess".
  String name;

  /// Code members use to join — unique, generated server-side.
  String inviteCode;

  /// The AuthUser id of whoever created this mess (its first manager).
  _i1.UuidValue ownerAuthUserId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mess',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerAuthUserId': ownerAuthUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static MessInclude include() {
    return MessInclude._();
  }

  static MessIncludeList includeList({
    _i1.WhereExpressionBuilder<MessTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessTable>? orderByList,
    MessInclude? include,
  }) {
    return MessIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mess.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Mess.t),
      include: include,
    );
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

class MessUpdateTable extends _i1.UpdateTable<MessTable> {
  MessUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> inviteCode(String value) => _i1.ColumnValue(
    table.inviteCode,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ownerAuthUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.ownerAuthUserId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class MessTable extends _i1.Table<int?> {
  MessTable({super.tableRelation}) : super(tableName: 'mess') {
    updateTable = MessUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    inviteCode = _i1.ColumnString(
      'inviteCode',
      this,
    );
    ownerAuthUserId = _i1.ColumnUuid(
      'ownerAuthUserId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final MessUpdateTable updateTable;

  /// Human-readable name, e.g. "Sunshine Mess".
  late final _i1.ColumnString name;

  /// Code members use to join — unique, generated server-side.
  late final _i1.ColumnString inviteCode;

  /// The AuthUser id of whoever created this mess (its first manager).
  late final _i1.ColumnUuid ownerAuthUserId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    inviteCode,
    ownerAuthUserId,
    createdAt,
  ];
}

class MessInclude extends _i1.IncludeObject {
  MessInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Mess.t;
}

class MessIncludeList extends _i1.IncludeList {
  MessIncludeList._({
    _i1.WhereExpressionBuilder<MessTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mess.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Mess.t;
}

class MessRepository {
  const MessRepository._();

  /// Returns a list of [Mess]s matching the given query parameters.
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
  Future<List<Mess>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mess>(
      where: where?.call(Mess.t),
      orderBy: orderBy?.call(Mess.t),
      orderByList: orderByList?.call(Mess.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mess] matching the given query parameters.
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
  Future<Mess?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessTable>? where,
    int? offset,
    _i1.OrderByBuilder<MessTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mess>(
      where: where?.call(Mess.t),
      orderBy: orderBy?.call(Mess.t),
      orderByList: orderByList?.call(Mess.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mess] by its [id] or null if no such row exists.
  Future<Mess?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mess>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mess]s in the list and returns the inserted rows.
  ///
  /// The returned [Mess]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Mess>> insert(
    _i1.DatabaseSession session,
    List<Mess> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Mess>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Mess] and returns the inserted row.
  ///
  /// The returned [Mess] will have its `id` field set.
  Future<Mess> insertRow(
    _i1.DatabaseSession session,
    Mess row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mess>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Mess]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Mess>> update(
    _i1.DatabaseSession session,
    List<Mess> rows, {
    _i1.ColumnSelections<MessTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Mess>(
      rows,
      columns: columns?.call(Mess.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mess]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mess> updateRow(
    _i1.DatabaseSession session,
    Mess row, {
    _i1.ColumnSelections<MessTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mess>(
      row,
      columns: columns?.call(Mess.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mess] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mess?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MessUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Mess>(
      id,
      columnValues: columnValues(Mess.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mess]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Mess>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MessUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MessTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessTable>? orderBy,
    _i1.OrderByListBuilder<MessTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Mess>(
      columnValues: columnValues(Mess.t.updateTable),
      where: where(Mess.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mess.t),
      orderByList: orderByList?.call(Mess.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Mess]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Mess>> delete(
    _i1.DatabaseSession session,
    List<Mess> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Mess>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Mess].
  Future<Mess> deleteRow(
    _i1.DatabaseSession session,
    Mess row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mess>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Mess>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Mess>(
      where: where(Mess.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Mess>(
      where: where?.call(Mess.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mess] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mess>(
      where: where(Mess.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
