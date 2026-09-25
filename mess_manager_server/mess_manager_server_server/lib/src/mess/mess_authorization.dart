import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// "Who is the caller, and are they a manager" — every mess-scoped
/// endpoint (Mess, Meal, Expense, ...) needs these same two checks.
extension MessAuthorization on Session {
  Future<MessMember> requireCurrentMembership() async {
    final authUserId = authenticated!.authUserId;
    final membership = await MessMember.db.findFirstRow(
      this,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (membership == null) {
      throw MessMemberNotFoundException();
    }
    return membership;
  }

  Future<MessMember> requireManager() async {
    final membership = await requireCurrentMembership();
    if (membership.role != MessMemberRole.manager) {
      throw NotMessManagerException();
    }
    return membership;
  }

  /// Looks up [memberId], throwing if it doesn't exist or belongs to a
  /// different mess than [messId] — the check every endpoint needs before
  /// attributing a row (an expense, a payment, ...) to a member id it was
  /// merely handed as an int.
  Future<MessMember> requireMemberInMess(int memberId, int messId) async {
    final member = await MessMember.db.findById(this, memberId);
    if (member == null || member.messId != messId) {
      throw MessMemberNotFoundException();
    }
    return member;
  }
}
