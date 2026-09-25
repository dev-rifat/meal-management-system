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
import '../../mess/models/meal_status.dart' as _i2;
import '../../mess/models/mess.dart' as _i3;
import '../../mess/models/mess_member.dart' as _i4;
import '../../mess/models/meal_type.dart' as _i5;
import 'package:mess_manager_server_server/src/generated/protocol.dart' as _i6;

/// One member's meal count for one day and meal type — e.g. "Jane, 2026-01-05,
/// lunch, 1.0". Replaces two disconnected mock concepts (a per-day,
/// ownerless `MealRecord` with a status, and a per-member `ManagerMealEntry`
/// with no status/read path) with one real, per-entry model: a member (or
/// their manager) submits it, a manager approves/rejects it.
abstract class MealEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MealEntry._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.date,
    required this.mealType,
    required this.mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.MealStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory MealEntry({
    int? id,
    required int messId,
    _i3.Mess? mess,
    required int memberId,
    _i4.MessMember? member,
    required DateTime date,
    required _i5.MealType mealType,
    required double mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) = _MealEntryImpl;

  factory MealEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealEntry(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.MessMember>(
              jsonSerialization['member'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealType: _i5.MealType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      mealCount: (jsonSerialization['mealCount'] as num).toDouble(),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.MealStatus.fromJson((jsonSerialization['status'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = MealEntryTable();

  static const db = MealEntryRepository._();

  @override
  int? id;

  int messId;

  _i3.Mess? mess;

  int memberId;

  _i4.MessMember? member;

  DateTime date;

  _i5.MealType mealType;

  double mealCount;

  _i2.MealStatus status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealEntry copyWith({
    int? id,
    int? messId,
    _i3.Mess? mess,
    int? memberId,
    _i4.MessMember? member,
    DateTime? date,
    _i5.MealType? mealType,
    double? mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealEntry',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      'mealCount': mealCount,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealEntry',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJsonForProtocol(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJsonForProtocol(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      'mealCount': mealCount,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static MealEntryInclude include({
    _i3.MessInclude? mess,
    _i4.MessMemberInclude? member,
  }) {
    return MealEntryInclude._(
      mess: mess,
      member: member,
    );
  }

  static MealEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    MealEntryInclude? include,
  }) {
    return MealEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MealEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealEntryImpl extends MealEntry {
  _MealEntryImpl({
    int? id,
    required int messId,
    _i3.Mess? mess,
    required int memberId,
    _i4.MessMember? member,
    required DateTime date,
    required _i5.MealType mealType,
    required double mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         date: date,
         mealType: mealType,
         mealCount: mealCount,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealEntry copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    DateTime? date,
    _i5.MealType? mealType,
    double? mealCount,
    _i2.MealStatus? status,
    DateTime? createdAt,
  }) {
    return MealEntry(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i3.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i4.MessMember? ? member : this.member?.copyWith(),
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      mealCount: mealCount ?? this.mealCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MealEntryUpdateTable extends _i1.UpdateTable<MealEntryTable> {
  MealEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> messId(int value) => _i1.ColumnValue(
    table.messId,
    value,
  );

  _i1.ColumnValue<int, int> memberId(int value) => _i1.ColumnValue(
    table.memberId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<_i5.MealType, _i5.MealType> mealType(_i5.MealType value) =>
      _i1.ColumnValue(
        table.mealType,
        value,
      );

  _i1.ColumnValue<double, double> mealCount(double value) => _i1.ColumnValue(
    table.mealCount,
    value,
  );

  _i1.ColumnValue<_i2.MealStatus, _i2.MealStatus> status(
    _i2.MealStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class MealEntryTable extends _i1.Table<int?> {
  MealEntryTable({super.tableRelation}) : super(tableName: 'meal_entry') {
    updateTable = MealEntryUpdateTable(this);
    messId = _i1.ColumnInt(
      'messId',
      this,
    );
    memberId = _i1.ColumnInt(
      'memberId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    mealType = _i1.ColumnEnum(
      'mealType',
      this,
      _i1.EnumSerialization.byName,
    );
    mealCount = _i1.ColumnDouble(
      'mealCount',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final MealEntryUpdateTable updateTable;

  late final _i1.ColumnInt messId;

  _i3.MessTable? _mess;

  late final _i1.ColumnInt memberId;

  _i4.MessMemberTable? _member;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnEnum<_i5.MealType> mealType;

  late final _i1.ColumnDouble mealCount;

  late final _i1.ColumnEnum<_i2.MealStatus> status;

  late final _i1.ColumnDateTime createdAt;

  _i3.MessTable get mess {
    if (_mess != null) return _mess!;
    _mess = _i1.createRelationTable(
      relationFieldName: 'mess',
      field: MealEntry.t.messId,
      foreignField: _i3.Mess.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MessTable(tableRelation: foreignTableRelation),
    );
    return _mess!;
  }

  _i4.MessMemberTable get member {
    if (_member != null) return _member!;
    _member = _i1.createRelationTable(
      relationFieldName: 'member',
      field: MealEntry.t.memberId,
      foreignField: _i4.MessMember.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MessMemberTable(tableRelation: foreignTableRelation),
    );
    return _member!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    messId,
    memberId,
    date,
    mealType,
    mealCount,
    status,
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
    return null;
  }
}

class MealEntryInclude extends _i1.IncludeObject {
  MealEntryInclude._({
    _i3.MessInclude? mess,
    _i4.MessMemberInclude? member,
  }) {
    _mess = mess;
    _member = member;
  }

  _i3.MessInclude? _mess;

  _i4.MessMemberInclude? _member;

  @override
  Map<String, _i1.Include?> get includes => {
    'mess': _mess,
    'member': _member,
  };

  @override
  _i1.Table<int?> get table => MealEntry.t;
}

class MealEntryIncludeList extends _i1.IncludeList {
  MealEntryIncludeList._({
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MealEntry.t;
}

class MealEntryRepository {
  const MealEntryRepository._();

  final attachRow = const MealEntryAttachRowRepository._();

  /// Returns a list of [MealEntry]s matching the given query parameters.
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
  Future<List<MealEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    _i1.Transaction? transaction,
    MealEntryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MealEntry>(
      where: where?.call(MealEntry.t),
      orderBy: orderBy?.call(MealEntry.t),
      orderByList: orderByList?.call(MealEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MealEntry] matching the given query parameters.
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
  Future<MealEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    _i1.Transaction? transaction,
    MealEntryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MealEntry>(
      where: where?.call(MealEntry.t),
      orderBy: orderBy?.call(MealEntry.t),
      orderByList: orderByList?.call(MealEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MealEntry] by its [id] or null if no such row exists.
  Future<MealEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    MealEntryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MealEntry>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MealEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [MealEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MealEntry>> insert(
    _i1.DatabaseSession session,
    List<MealEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MealEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MealEntry] and returns the inserted row.
  ///
  /// The returned [MealEntry] will have its `id` field set.
  Future<MealEntry> insertRow(
    _i1.DatabaseSession session,
    MealEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MealEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MealEntry>> update(
    _i1.DatabaseSession session,
    List<MealEntry> rows, {
    _i1.ColumnSelections<MealEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MealEntry>(
      rows,
      columns: columns?.call(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealEntry> updateRow(
    _i1.DatabaseSession session,
    MealEntry row, {
    _i1.ColumnSelections<MealEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealEntry>(
      row,
      columns: columns?.call(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MealEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MealEntry>(
      id,
      columnValues: columnValues(MealEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MealEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MealEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MealEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MealEntry>(
      columnValues: columnValues(MealEntry.t.updateTable),
      where: where(MealEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealEntry.t),
      orderByList: orderByList?.call(MealEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MealEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MealEntry>> delete(
    _i1.DatabaseSession session,
    List<MealEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MealEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MealEntry].
  Future<MealEntry> deleteRow(
    _i1.DatabaseSession session,
    MealEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MealEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MealEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MealEntry>(
      where: where(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MealEntry>(
      where: where?.call(MealEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MealEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MealEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MealEntry>(
      where: where(MealEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MealEntryAttachRowRepository {
  const MealEntryAttachRowRepository._();

  /// Creates a relation between the given [MealEntry] and [Mess]
  /// by setting the [MealEntry]'s foreign key `messId` to refer to the [Mess].
  Future<void> mess(
    _i1.DatabaseSession session,
    MealEntry mealEntry,
    _i3.Mess mess, {
    _i1.Transaction? transaction,
  }) async {
    if (mealEntry.id == null) {
      throw ArgumentError.notNull('mealEntry.id');
    }
    if (mess.id == null) {
      throw ArgumentError.notNull('mess.id');
    }

    var $mealEntry = mealEntry.copyWith(messId: mess.id);
    await session.db.updateRow<MealEntry>(
      $mealEntry,
      columns: [MealEntry.t.messId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MealEntry] and [MessMember]
  /// by setting the [MealEntry]'s foreign key `memberId` to refer to the [MessMember].
  Future<void> member(
    _i1.DatabaseSession session,
    MealEntry mealEntry,
    _i4.MessMember member, {
    _i1.Transaction? transaction,
  }) async {
    if (mealEntry.id == null) {
      throw ArgumentError.notNull('mealEntry.id');
    }
    if (member.id == null) {
      throw ArgumentError.notNull('member.id');
    }

    var $mealEntry = mealEntry.copyWith(memberId: member.id);
    await session.db.updateRow<MealEntry>(
      $mealEntry,
      columns: [MealEntry.t.memberId],
      transaction: transaction,
    );
  }
}
