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
import 'package:mess_manager_server_server/src/generated/protocol.dart' as _i4;

/// A deposit a member has paid into the mess — the credit side of their
/// balance (their [Expense] rows are the debit side). Recorded by a
/// manager, e.g. after collecting cash from a member.
abstract class Payment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Payment._({
    this.id,
    required this.messId,
    this.mess,
    required this.memberId,
    this.member,
    required this.amount,
    required this.date,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Payment({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required double amount,
    required DateTime date,
    DateTime? createdAt,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Mess>(jsonSerialization['mess']),
      memberId: jsonSerialization['memberId'] as int,
      member: jsonSerialization['member'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.MessMember>(
              jsonSerialization['member'],
            ),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PaymentTable();

  static const db = PaymentRepository._();

  @override
  int? id;

  int messId;

  _i2.Mess? mess;

  int memberId;

  _i3.MessMember? member;

  double amount;

  DateTime date;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? messId,
    _i2.Mess? mess,
    int? memberId,
    _i3.MessMember? member,
    double? amount,
    DateTime? date,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'messId': messId,
      if (mess != null) 'mess': mess?.toJsonForProtocol(),
      'memberId': memberId,
      if (member != null) 'member': member?.toJsonForProtocol(),
      'amount': amount,
      'date': date.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static PaymentInclude include({
    _i2.MessInclude? mess,
    _i3.MessMemberInclude? member,
  }) {
    return PaymentInclude._(
      mess: mess,
      member: member,
    );
  }

  static PaymentIncludeList includeList({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    PaymentInclude? include,
  }) {
    return PaymentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Payment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int messId,
    _i2.Mess? mess,
    required int memberId,
    _i3.MessMember? member,
    required double amount,
    required DateTime date,
    DateTime? createdAt,
  }) : super._(
         id: id,
         messId: messId,
         mess: mess,
         memberId: memberId,
         member: member,
         amount: amount,
         date: date,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? messId,
    Object? mess = _Undefined,
    int? memberId,
    Object? member = _Undefined,
    double? amount,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      messId: messId ?? this.messId,
      mess: mess is _i2.Mess? ? mess : this.mess?.copyWith(),
      memberId: memberId ?? this.memberId,
      member: member is _i3.MessMember? ? member : this.member?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PaymentUpdateTable extends _i1.UpdateTable<PaymentTable> {
  PaymentUpdateTable(super.table);

  _i1.ColumnValue<int, int> messId(int value) => _i1.ColumnValue(
    table.messId,
    value,
  );

  _i1.ColumnValue<int, int> memberId(int value) => _i1.ColumnValue(
    table.memberId,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PaymentTable extends _i1.Table<int?> {
  PaymentTable({super.tableRelation}) : super(tableName: 'payment') {
    updateTable = PaymentUpdateTable(this);
    messId = _i1.ColumnInt(
      'messId',
      this,
    );
    memberId = _i1.ColumnInt(
      'memberId',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PaymentUpdateTable updateTable;

  late final _i1.ColumnInt messId;

  _i2.MessTable? _mess;

  late final _i1.ColumnInt memberId;

  _i3.MessMemberTable? _member;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnDateTime createdAt;

  _i2.MessTable get mess {
    if (_mess != null) return _mess!;
    _mess = _i1.createRelationTable(
      relationFieldName: 'mess',
      field: Payment.t.messId,
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
      field: Payment.t.memberId,
      foreignField: _i3.MessMember.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MessMemberTable(tableRelation: foreignTableRelation),
    );
    return _member!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    messId,
    memberId,
    amount,
    date,
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

class PaymentInclude extends _i1.IncludeObject {
  PaymentInclude._({
    _i2.MessInclude? mess,
    _i3.MessMemberInclude? member,
  }) {
    _mess = mess;
    _member = member;
  }

  _i2.MessInclude? _mess;

  _i3.MessMemberInclude? _member;

  @override
  Map<String, _i1.Include?> get includes => {
    'mess': _mess,
    'member': _member,
  };

  @override
  _i1.Table<int?> get table => Payment.t;
}

class PaymentIncludeList extends _i1.IncludeList {
  PaymentIncludeList._({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Payment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Payment.t;
}

class PaymentRepository {
  const PaymentRepository._();

  final attachRow = const PaymentAttachRowRepository._();

  /// Returns a list of [Payment]s matching the given query parameters.
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
  Future<List<Payment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
    PaymentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Payment] matching the given query parameters.
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
  Future<Payment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
    PaymentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Payment] by its [id] or null if no such row exists.
  Future<Payment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    PaymentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Payment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Payment]s in the list and returns the inserted rows.
  ///
  /// The returned [Payment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Payment>> insert(
    _i1.DatabaseSession session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Payment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Payment] and returns the inserted row.
  ///
  /// The returned [Payment] will have its `id` field set.
  Future<Payment> insertRow(
    _i1.DatabaseSession session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Payment>> update(
    _i1.DatabaseSession session,
    List<Payment> rows, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Payment>(
      rows,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Payment> updateRow(
    _i1.DatabaseSession session,
    Payment row, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Payment>(
      row,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Payment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Payment>(
      id,
      columnValues: columnValues(Payment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Payment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Payment>(
      columnValues: columnValues(Payment.t.updateTable),
      where: where(Payment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Payment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Payment>> delete(
    _i1.DatabaseSession session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Payment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Payment].
  Future<Payment> deleteRow(
    _i1.DatabaseSession session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Payment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Payment>(
      where: where(Payment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Payment>(
      where: where?.call(Payment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Payment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Payment>(
      where: where(Payment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PaymentAttachRowRepository {
  const PaymentAttachRowRepository._();

  /// Creates a relation between the given [Payment] and [Mess]
  /// by setting the [Payment]'s foreign key `messId` to refer to the [Mess].
  Future<void> mess(
    _i1.DatabaseSession session,
    Payment payment,
    _i2.Mess mess, {
    _i1.Transaction? transaction,
  }) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (mess.id == null) {
      throw ArgumentError.notNull('mess.id');
    }

    var $payment = payment.copyWith(messId: mess.id);
    await session.db.updateRow<Payment>(
      $payment,
      columns: [Payment.t.messId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Payment] and [MessMember]
  /// by setting the [Payment]'s foreign key `memberId` to refer to the [MessMember].
  Future<void> member(
    _i1.DatabaseSession session,
    Payment payment,
    _i3.MessMember member, {
    _i1.Transaction? transaction,
  }) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (member.id == null) {
      throw ArgumentError.notNull('member.id');
    }

    var $payment = payment.copyWith(memberId: member.id);
    await session.db.updateRow<Payment>(
      $payment,
      columns: [Payment.t.memberId],
      transaction: transaction,
    );
  }
}
