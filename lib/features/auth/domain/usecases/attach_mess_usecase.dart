import 'package:equatable/equatable.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class AttachMessParams extends Equatable {
  final String messId;
  final UserRole role;

  const AttachMessParams({required this.messId, required this.role});

  @override
  List<Object?> get props => [messId, role];
}

class AttachMessUseCase implements UseCase<AuthUser, AttachMessParams> {
  final AuthRepository repository;

  const AttachMessUseCase(this.repository);

  @override
  Future<Result<AuthUser>> call(AttachMessParams params) {
    return repository.attachMess(messId: params.messId, role: params.role);
  }
}
