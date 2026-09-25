import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'mess_authorization.dart';

/// Create/join a mess — the step that runs right after the caller registers
/// through Serverpod's built-in email-auth endpoints. Requires login; each
/// AuthUser can complete this at most once ([MessMember.authUserId] is
/// unique), matching the app's one-mess-per-account flow.
class MessEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  static final _random = Random.secure();
  static const _userProfiles = UserProfiles();

  /// Creates a new mess and attaches the caller to it as manager. Returns
  /// the [Mess] (not the [MessMember] join row) — the invite code is what
  /// the caller actually needs back, to show the user.
  Future<Mess> create(
    Session session, {
    required String name,
    required String phone,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    await _requireNoExistingMembership(session, authUserId);

    final inviteCode = await _generateUniqueInviteCode(session);
    final mess = await Mess.db.insertRow(
      session,
      Mess(name: name, inviteCode: inviteCode, ownerAuthUserId: authUserId),
    );

    await MessMember.db.insertRow(
      session,
      MessMember(
        authUserId: authUserId,
        messId: mess.id!,
        role: MessMemberRole.manager,
        phone: phone,
      ),
    );
    return mess;
  }

  /// Joins an existing mess by its invite code, attaching the caller as a
  /// member. Returns the joined [Mess].
  Future<Mess> join(
    Session session, {
    required String inviteCode,
    required String phone,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    await _requireNoExistingMembership(session, authUserId);

    final mess = await Mess.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(inviteCode.trim().toUpperCase()),
    );
    if (mess == null) {
      throw MessNotFoundException();
    }

    await MessMember.db.insertRow(
      session,
      MessMember(
        authUserId: authUserId,
        messId: mess.id!,
        role: MessMemberRole.member,
        phone: phone,
      ),
    );
    return mess;
  }

  /// The current caller's membership row, or null if they haven't
  /// created/joined a mess yet.
  Future<MessMember?> currentMembership(Session session) {
    final authUserId = session.authenticated!.authUserId;
    return MessMember.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Every member of the caller's own mess, combining [MessMember] with
  /// their Serverpod profile (name/email) — see [MessMemberProfile]'s doc
  /// comment for why this isn't just a plain table row.
  Future<List<MessMemberProfile>> members(Session session) async {
    final caller = await session.requireCurrentMembership();
    final rows = await MessMember.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId),
      orderBy: (t) => t.joiningDate,
    );

    final result = <MessMemberProfile>[];
    for (final row in rows) {
      final profile = await _userProfiles.maybeFindUserProfileByUserId(
        session,
        row.authUserId,
      );
      result.add(
        MessMemberProfile(
          id: row.id!,
          authUserId: row.authUserId,
          name: profile?.fullName ?? profile?.userName ?? '',
          email: profile?.email ?? '',
          phone: row.phone,
          role: row.role,
          paymentStatus: row.paymentStatus,
          paymentDate: row.paymentDate,
          joiningDate: row.joiningDate,
          profileImageUrl: profile?.imageUrl?.toString(),
        ),
      );
    }
    return result;
  }

  /// Updates a member's payment status — manager-only, and only within the
  /// manager's own mess.
  Future<void> updateMemberPayment(
    Session session, {
    required int memberId,
    required MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  }) async {
    final caller = await session.requireManager();

    final target = await MessMember.db.findById(session, memberId);
    if (target == null || target.messId != caller.messId) {
      throw MessMemberNotFoundException();
    }

    await MessMember.db.updateRow(
      session,
      target.copyWith(paymentStatus: paymentStatus, paymentDate: paymentDate),
    );
  }

  /// Removes a member from the caller's mess — manager-only. A manager
  /// can't remove themself this way (there'd be no manager left); that's
  /// intentionally unsupported for now.
  Future<void> removeMember(Session session, {required int memberId}) async {
    final caller = await session.requireManager();

    final target = await MessMember.db.findById(session, memberId);
    if (target == null || target.messId != caller.messId) {
      throw MessMemberNotFoundException();
    }
    if (target.authUserId == caller.authUserId) {
      throw NotMessManagerException();
    }

    await MessMember.db.deleteRow(session, target);
  }

  Future<void> _requireNoExistingMembership(
    Session session,
    UuidValue authUserId,
  ) async {
    final existing = await MessMember.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) {
      throw AlreadyInAMessException();
    }
  }

  Future<String> _generateUniqueInviteCode(Session session) async {
    while (true) {
      final code = List.generate(
        6,
        (_) => _codeAlphabet[_random.nextInt(_codeAlphabet.length)],
      ).join();
      final existing = await Mess.db.findFirstRow(
        session,
        where: (t) => t.inviteCode.equals(code),
      );
      if (existing == null) return code;
    }
  }
}
