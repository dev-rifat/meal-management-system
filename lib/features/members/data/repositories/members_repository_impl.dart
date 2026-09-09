import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/members/data/datasources/members_local_data_source.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class MembersRepositoryImpl implements MembersRepository {
  final MembersLocalDataSource localDataSource;

  const MembersRepositoryImpl(this.localDataSource);

  @override
  Future<Result<List<Member>>> getMembers({String query = ''}) =>
      guard(() async => localDataSource.getMembers(query: query));

  @override
  Future<Result<void>> deleteMember(String id) =>
      guard(() async => localDataSource.deleteMember(id));

  @override
  Future<Result<Member>> updateMember(Member member) =>
      guard(() async => localDataSource.updateMember(member));
}
