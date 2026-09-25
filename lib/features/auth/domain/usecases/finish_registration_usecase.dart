import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class FinishRegistrationParams extends Equatable {
  final String registrationToken;
  final String password;
  final String fullName;

  const FinishRegistrationParams({
    required this.registrationToken,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [registrationToken, password, fullName];
}

/// Creates the account and signs the user in. The account has no mess yet —
/// that's a separate step via `MessRepository`.
class FinishRegistrationUseCase
    implements UseCase<AuthUser, FinishRegistrationParams> {
  final AuthRepository repository;

  const FinishRegistrationUseCase(this.repository);

  @override
  Future<Result<AuthUser>> call(FinishRegistrationParams params) {
    return repository.finishRegistration(
      registrationToken: params.registrationToken,
      password: params.password,
      fullName: params.fullName,
    );
  }
}
