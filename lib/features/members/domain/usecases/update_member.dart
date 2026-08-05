import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class UpdateMemberParams extends Equatable {
  final Member member;

  const UpdateMemberParams(this.member);

  @override
  List<Object?> get props => [member];
}

class UpdateMember implements UseCase<Member, UpdateMemberParams> {
  final MembersRepository repository;

  const UpdateMember(this.repository);

  @override
  Future<Result<Member>> call(UpdateMemberParams params) {
    return repository.updateMember(params.member);
  }
}
