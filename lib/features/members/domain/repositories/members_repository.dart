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

  Future<Result<Member>> updateMember(Member member);
}
