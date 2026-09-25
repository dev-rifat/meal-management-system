import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

/// Contract the data layer must fulfil for anything member-list related.
/// The presentation layer (via the use cases) only ever talks to this
/// interface.
abstract class MembersRepository {
  /// Returns members matching [query] against name/username/email
  /// (case-insensitive). An empty query returns every member.
  Future<Result<List<Member>>> getMembers({String query = ''});

  Future<Result<void>> deleteMember(String id);

  Future<Result<void>> updateMemberPayment({
    required String id,
    required MemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  });

  /// Records a deposit [amount] for member [id] on [date] — the credit
  /// side of their balance, shown back on the dashboard/wallet screens.
  /// Manager-only, enforced server-side.
  Future<Result<void>> recordPayment({
    required String id,
    required double amount,
    required DateTime date,
  });
}
