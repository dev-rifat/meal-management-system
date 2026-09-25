import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/members/data/datasources/members_remote_data_source.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart' as server;

class MembersRepositoryImpl implements MembersRepository {
  final MembersRemoteDataSource remoteDataSource;

  const MembersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<Member>>> getMembers({String query = ''}) => guard(() async {
    final rows = await remoteDataSource.getMembers();
    final members = rows.map(_toDomain).toList();
    if (query.isEmpty) return members;

    final lowerQuery = query.toLowerCase();
    return members
        .where(
          (m) =>
              m.name.toLowerCase().contains(lowerQuery) ||
              m.username.toLowerCase().contains(lowerQuery) ||
              m.email.toLowerCase().contains(lowerQuery),
        )
        .toList();
  });

  @override
  Future<Result<void>> deleteMember(String id) =>
      guard(() => remoteDataSource.deleteMember(int.parse(id)));

  @override
  Future<Result<void>> updateMemberPayment({
    required String id,
    required MemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  }) => guard(
    () => remoteDataSource.updateMemberPayment(
      id: int.parse(id),
      paymentStatus: switch (paymentStatus) {
        MemberPaymentStatus.due => server.MessMemberPaymentStatus.due,
        MemberPaymentStatus.clear => server.MessMemberPaymentStatus.clear,
      },
      paymentDate: paymentDate,
    ),
  );

  @override
  Future<Result<void>> recordPayment({
    required String id,
    required double amount,
    required DateTime date,
  }) => guard(
    () => remoteDataSource.recordPayment(id: int.parse(id), amount: amount, date: date),
  );

  Member _toDomain(server.MessMemberProfile row) {
    final username = row.name.isNotEmpty
        ? '@${row.name.split(' ').first.toLowerCase()}'
        : '';
    return Member(
      id: row.id.toString(),
      name: row.name,
      username: username,
      email: row.email,
      profileImage:
          row.profileImageUrl ?? 'https://i.pravatar.cc/150?u=${row.authUserId}',
      joiningDate: row.joiningDate,
      paymentStatus: switch (row.paymentStatus) {
        server.MessMemberPaymentStatus.due => MemberPaymentStatus.due,
        server.MessMemberPaymentStatus.clear => MemberPaymentStatus.clear,
      },
      paymentDate: row.paymentDate,
    );
  }
}
