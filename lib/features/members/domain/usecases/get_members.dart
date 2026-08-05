import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class GetMembersParams extends Equatable {
  final String query;

  const GetMembersParams({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class GetMembers implements UseCase<List<Member>, GetMembersParams> {
  final MembersRepository repository;

  const GetMembers(this.repository);

  @override
  Future<Result<List<Member>>> call(GetMembersParams params) {
    return repository.getMembers(query: params.query);
  }
}
