import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'mess_authorization.dart';

/// A member's deposits into the mess — the credit side of their balance.
/// Any member can read; only a manager can record one (e.g. after
/// collecting cash).
class PaymentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Payment> addPayment(
    Session session, {
    required int memberId,
    required double amount,
    required DateTime date,
  }) async {
    final caller = await session.requireManager();
    final member = await session.requireMemberInMess(memberId, caller.messId);

    return Payment.db.insertRow(
      session,
      Payment(messId: caller.messId, memberId: member.id!, amount: amount, date: date),
    );
  }

  /// Every payment recorded in the caller's mess, newest first.
  Future<List<Payment>> getPayments(Session session) async {
    final caller = await session.requireCurrentMembership();
    return Payment.db.find(
      session,
      where: (t) => t.messId.equals(caller.messId),
      orderBy: (t) => t.date,
      orderDescending: true,
    );
  }
}
