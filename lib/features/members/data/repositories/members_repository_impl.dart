import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/core/error/failure.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/members/data/datasources/members_local_data_source.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class MembersRepositoryImpl implements MembersRepository {
  final MembersLocalDataSource localDataSource;

  const MembersRepositoryImpl(this.localDataSource);

  @override
  Future<Result<List<Member>>> getMembers({String query = ''}) async {
    try {
      return ResultSuccess(localDataSource.getMembers(query: query));
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Result<void>> deleteMember(String id) async {
    try {
      localDataSource.deleteMember(id);
      return const ResultSuccess(null);
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Result<Member>> updateMember(Member member) async {
    try {
      return ResultSuccess(localDataSource.updateMember(member));
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    }
  }
}
