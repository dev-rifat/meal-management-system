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
import '../../mess/models/mess_member_role.dart' as _i2;
import '../../mess/models/mess_member_payment_status.dart' as _i3;
import '../../mess/models/mess.dart' as _i4;
import 'package:mess_manager_server_server/src/generated/protocol.dart' as _i5;

/// App-specific data for a person within a mess. Serverpod's built-in
/// AuthUser/UserProfile (serverpod_auth_core) already own identity
/// (email/password) and basic profile (name); this model holds only what
/// this app adds on top — phone, role, mess membership, payment status —
/// and links back to that AuthUser by id.
abstract class MessMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MessMember._({
    this.id,
    required this.authUserId,
    required this.messId,
    this.mess,
    _i2.MessMemberRole? role,
    required this.phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    this.paymentDate,
    DateTime? joiningDate,
    this.emergencyContact,
    this.birthday,
  }) : role = role ?? _i2.MessMemberRole.member,
       paymentStatus = paymentStatus ?? _i3.MessMemberPaymentStatus.due,
       joiningDate = joiningDate ?? DateTime.now();

  factory MessMember({
    int? id,
    required _i1.UuidValue authUserId,
    required int messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    required String phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  }) = _MessMemberImpl;

  factory MessMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessMember(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      messId: jsonSerialization['messId'] as int,
      mess: jsonSerialization['mess'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Mess>(jsonSerialization['mess']),
      role: jsonSerialization['role'] == null
          ? null
          : _i2.MessMemberRole.fromJson((jsonSerialization['role'] as String)),
      phone: jsonSerialization['phone'] as String,
      paymentStatus: jsonSerialization['paymentStatus'] == null
          ? null
          : _i3.MessMemberPaymentStatus.fromJson(
              (jsonSerialization['paymentStatus'] as String),
            ),
      paymentDate: jsonSerialization['paymentDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['paymentDate'],
            ),
      joiningDate: jsonSerialization['joiningDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['joiningDate'],
            ),
      emergencyContact: jsonSerialization['emergencyContact'] as String?,
      birthday: jsonSerialization['birthday'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['birthday']),
    );
  }

  static final t = MessMemberTable();

  static const db = MessMemberRepository._();

  @override
  int? id;

  /// The Serverpod AuthUser id this member is signed in as.
  _i1.UuidValue authUserId;

  int messId;

  /// The mess this member belongs to.
  _i4.Mess? mess;

  _i2.MessMemberRole role;

  String phone;

  _i3.MessMemberPaymentStatus paymentStatus;

  DateTime? paymentDate;

  DateTime joiningDate;

  String? emergencyContact;

  DateTime? birthday;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MessMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessMember copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    int? messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    String? phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessMember',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'messId': messId,
      if (mess != null) 'mess': mess?.toJson(),
      'role': role.toJson(),
      'phone': phone,
      'paymentStatus': paymentStatus.toJson(),
      if (paymentDate != null) 'paymentDate': paymentDate?.toJson(),
      'joiningDate': joiningDate.toJson(),
      if (emergencyContact != null) 'emergencyContact': emergencyContact,
      if (birthday != null) 'birthday': birthday?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MessMember',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'messId': messId,
      if (mess != null) 'mess': mess?.toJsonForProtocol(),
      'role': role.toJson(),
      'phone': phone,
      'paymentStatus': paymentStatus.toJson(),
      if (paymentDate != null) 'paymentDate': paymentDate?.toJson(),
      'joiningDate': joiningDate.toJson(),
      if (emergencyContact != null) 'emergencyContact': emergencyContact,
      if (birthday != null) 'birthday': birthday?.toJson(),
    };
  }

  static MessMemberInclude include({_i4.MessInclude? mess}) {
    return MessMemberInclude._(mess: mess);
  }

  static MessMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<MessMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessMemberTable>? orderByList,
    MessMemberInclude? include,
  }) {
    return MessMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MessMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessMemberImpl extends MessMember {
  _MessMemberImpl({
    int? id,
    required _i1.UuidValue authUserId,
    required int messId,
    _i4.Mess? mess,
    _i2.MessMemberRole? role,
    required String phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
    DateTime? joiningDate,
    String? emergencyContact,
    DateTime? birthday,
  }) : super._(
         id: id,
         authUserId: authUserId,
         messId: messId,
         mess: mess,
         role: role,
         phone: phone,
         paymentStatus: paymentStatus,
         paymentDate: paymentDate,
         joiningDate: joiningDate,
         emergencyContact: emergencyContact,
         birthday: birthday,
       );

  /// Returns a shallow copy of this [MessMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessMember copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    int? messId,
    Object? mess = _Undefined,
    _i2.MessMemberRole? role,
    String? phone,
    _i3.MessMemberPaymentStatus? paymentStatus,
    Object? paymentDate = _Undefined,
    DateTime? joiningDate,
    Object? emergencyContact = _Undefined,
    Object? birthday = _Undefined,
  }) {
    return MessMember(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      messId: messId ?? this.messId,
      mess: mess is _i4.Mess? ? mess : this.mess?.copyWith(),
      role: role ?? this.role,
      phone: phone ?? this.phone,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentDate: paymentDate is DateTime? ? paymentDate : this.paymentDate,
      joiningDate: joiningDate ?? this.joiningDate,
      emergencyContact: emergencyContact is String?
          ? emergencyContact
          : this.emergencyContact,
      birthday: birthday is DateTime? ? birthday : this.birthday,
    );
  }
}

class MessMemberUpdateTable extends _i1.UpdateTable<MessMemberTable> {
  MessMemberUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<int, int> messId(int value) => _i1.ColumnValue(
    table.messId,
    value,
  );

  _i1.ColumnValue<_i2.MessMemberRole, _i2.MessMemberRole> role(
    _i2.MessMemberRole value,
  ) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<_i3.MessMemberPaymentStatus, _i3.MessMemberPaymentStatus>
  paymentStatus(_i3.MessMemberPaymentStatus value) => _i1.ColumnValue(
    table.paymentStatus,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> paymentDate(DateTime? value) =>
      _i1.ColumnValue(
        table.paymentDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> joiningDate(DateTime value) =>
      _i1.ColumnValue(
        table.joiningDate,
        value,
      );

  _i1.ColumnValue<String, String> emergencyContact(String? value) =>
      _i1.ColumnValue(
        table.emergencyContact,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> birthday(DateTime? value) =>
      _i1.ColumnValue(
        table.birthday,
        value,
      );
}

class MessMemberTable extends _i1.Table<int?> {
  MessMemberTable({super.tableRelation}) : super(tableName: 'mess_member') {
    updateTable = MessMemberUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    messId = _i1.ColumnInt(
      'messId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    paymentStatus = _i1.ColumnEnum(
      'paymentStatus',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    paymentDate = _i1.ColumnDateTime(
      'paymentDate',
      this,
    );
    joiningDate = _i1.ColumnDateTime(
      'joiningDate',
      this,
      hasDefault: true,
    );
    emergencyContact = _i1.ColumnString(
      'emergencyContact',
      this,
    );
    birthday = _i1.ColumnDateTime(
      'birthday',
      this,
    );
  }

  late final MessMemberUpdateTable updateTable;

  /// The Serverpod AuthUser id this member is signed in as.
  late final _i1.ColumnUuid authUserId;

  late final _i1.ColumnInt messId;

  /// The mess this member belongs to.
  _i4.MessTable? _mess;

  late final _i1.ColumnEnum<_i2.MessMemberRole> role;

  late final _i1.ColumnString phone;

  late final _i1.ColumnEnum<_i3.MessMemberPaymentStatus> paymentStatus;

  late final _i1.ColumnDateTime paymentDate;

  late final _i1.ColumnDateTime joiningDate;

  late final _i1.ColumnString emergencyContact;

  late final _i1.ColumnDateTime birthday;

  _i4.MessTable get mess {
    if (_mess != null) return _mess!;
    _mess = _i1.createRelationTable(
      relationFieldName: 'mess',
      field: MessMember.t.messId,
      foreignField: _i4.Mess.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MessTable(tableRelation: foreignTableRelation),
    );
    return _mess!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    messId,
    role,
    phone,
    paymentStatus,
    paymentDate,
    joiningDate,
    emergencyContact,
    birthday,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'mess') {
      return mess;
    }
    return null;
  }
}

class MessMemberInclude extends _i1.IncludeObject {
  MessMemberInclude._({_i4.MessInclude? mess}) {
    _mess = mess;
  }

  _i4.MessInclude? _mess;

  @override
  Map<String, _i1.Include?> get includes => {'mess': _mess};

  @override
  _i1.Table<int?> get table => MessMember.t;
}

class MessMemberIncludeList extends _i1.IncludeList {
  MessMemberIncludeList._({
    _i1.WhereExpressionBuilder<MessMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MessMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MessMember.t;
}

class MessMemberRepository {
  const MessMemberRepository._();

  final attachRow = const MessMemberAttachRowRepository._();

  /// Returns a list of [MessMember]s matching the given query parameters.
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
  Future<List<MessMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessMemberTable>? orderByList,
    _i1.Transaction? transaction,
    MessMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MessMember>(
      where: where?.call(MessMember.t),
      orderBy: orderBy?.call(MessMember.t),
      orderByList: orderByList?.call(MessMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MessMember] matching the given query parameters.
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
  Future<MessMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<MessMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessMemberTable>? orderByList,
    _i1.Transaction? transaction,
    MessMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MessMember>(
      where: where?.call(MessMember.t),
      orderBy: orderBy?.call(MessMember.t),
      orderByList: orderByList?.call(MessMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MessMember] by its [id] or null if no such row exists.
  Future<MessMember?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    MessMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MessMember>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MessMember]s in the list and returns the inserted rows.
  ///
  /// The returned [MessMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MessMember>> insert(
    _i1.DatabaseSession session,
    List<MessMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MessMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MessMember] and returns the inserted row.
  ///
  /// The returned [MessMember] will have its `id` field set.
  Future<MessMember> insertRow(
    _i1.DatabaseSession session,
    MessMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MessMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MessMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MessMember>> update(
    _i1.DatabaseSession session,
    List<MessMember> rows, {
    _i1.ColumnSelections<MessMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MessMember>(
      rows,
      columns: columns?.call(MessMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MessMember> updateRow(
    _i1.DatabaseSession session,
    MessMember row, {
    _i1.ColumnSelections<MessMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MessMember>(
      row,
      columns: columns?.call(MessMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MessMember?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MessMemberUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MessMember>(
      id,
      columnValues: columnValues(MessMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MessMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MessMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MessMemberUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MessMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessMemberTable>? orderBy,
    _i1.OrderByListBuilder<MessMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MessMember>(
      columnValues: columnValues(MessMember.t.updateTable),
      where: where(MessMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessMember.t),
      orderByList: orderByList?.call(MessMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MessMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MessMember>> delete(
    _i1.DatabaseSession session,
    List<MessMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MessMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MessMember].
  Future<MessMember> deleteRow(
    _i1.DatabaseSession session,
    MessMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MessMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MessMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MessMember>(
      where: where(MessMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MessMember>(
      where: where?.call(MessMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MessMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MessMember>(
      where: where(MessMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MessMemberAttachRowRepository {
  const MessMemberAttachRowRepository._();

  /// Creates a relation between the given [MessMember] and [Mess]
  /// by setting the [MessMember]'s foreign key `messId` to refer to the [Mess].
  Future<void> mess(
    _i1.DatabaseSession session,
    MessMember messMember,
    _i4.Mess mess, {
    _i1.Transaction? transaction,
  }) async {
    if (messMember.id == null) {
      throw ArgumentError.notNull('messMember.id');
    }
    if (mess.id == null) {
      throw ArgumentError.notNull('mess.id');
    }

    var $messMember = messMember.copyWith(messId: mess.id);
    await session.db.updateRow<MessMember>(
      $messMember,
      columns: [MessMember.t.messId],
      transaction: transaction,
    );
  }
}
