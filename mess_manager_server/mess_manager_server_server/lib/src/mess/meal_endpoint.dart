import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'mess_authorization.dart';

/// Meal entries — a member (or their manager) submits counts per day/meal
/// type; a manager approves/rejects them. See [MealEntry]'s doc comment
/// for why this replaces two disconnected mock concepts.
class MealEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Submits (or overwrites) [memberId]'s meal counts for [date] —
  /// re-submitting resets status to pending, since the counts changed and
  /// need re-approval. A non-manager can only submit for themself.
  Future<List<MealEntry>> submit(
    Session session, {
    required int memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  }) async {
    final caller = await session.requireCurrentMembership();
    if (memberId != caller.id && caller.role != MessMemberRole.manager) {
      throw NotMessManagerException();
    }
    final member = await MessMember.db.findById(session, memberId);
    if (member == null || member.messId != caller.messId) {
      throw MessMemberNotFoundException();
    }

    final saved = <MealEntry>[];
    for (final entry in mealCounts.entries) {
      final mealType = MealType.values.byName(entry.key);
      final existing = await MealEntry.db.findFirstRow(
        session,
        where: (t) =>
            t.memberId.equals(memberId) &
            t.date.equals(date) &
            t.mealType.equals(mealType),
      );
      if (existing != null) {
        saved.add(
          await MealEntry.db.updateRow(
            session,
            existing.copyWith(
              mealCount: entry.value,
              status: MealStatus.pending,
            ),
          ),
        );
      } else {
        saved.add(
          await MealEntry.db.insertRow(
            session,
            MealEntry(
              messId: caller.messId,
              memberId: memberId,
              date: date,
              mealType: mealType,
              mealCount: entry.value,
            ),
          ),
        );
      }
    }
    return saved;
  }

  /// Every meal entry in the caller's mess for [month] (matched by
  /// year+month, day ignored), optionally filtered by [status].
  Future<List<MealEntry>> getMealsForMonth(
    Session session, {
    required DateTime month,
    MealStatus? status,
  }) async {
    final caller = await session.requireCurrentMembership();
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1);
    return MealEntry.db.find(
      session,
      where: (t) {
        var expr = t.messId.equals(caller.messId) &
            t.date.between(start, end);
        if (status != null) expr = expr & t.status.equals(status);
        return expr;
      },
      orderBy: (t) => t.date,
    );
  }

  /// Manager-only.
  Future<MealEntry> updateStatus(
    Session session, {
    required int mealEntryId,
    required MealStatus status,
  }) async {
    final caller = await session.requireManager();
    final entry = await MealEntry.db.findById(session, mealEntryId);
    if (entry == null || entry.messId != caller.messId) {
      throw MealEntryNotFoundException();
    }
    return MealEntry.db.updateRow(session, entry.copyWith(status: status));
  }
}
