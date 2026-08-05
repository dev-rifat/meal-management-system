import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class DeleteMemberParams extends Equatable {
  final String id;

  const DeleteMemberParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteMember implements UseCase<void, DeleteMemberParams> {
  final MembersRepository repository;

  const DeleteMember(this.repository);

  @override
  Future<Result<void>> call(DeleteMemberParams params) {
    return repository.deleteMember(params.id);
  }
}
