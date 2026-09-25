import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class StartRegistrationParams extends Equatable {
  final String email;

  const StartRegistrationParams({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Kicks off registration and emails a verification code. Returns the
/// account-request id needed for [VerifyRegistrationCodeUseCase].
class StartRegistrationUseCase implements UseCase<String, StartRegistrationParams> {
  final AuthRepository repository;

  const StartRegistrationUseCase(this.repository);

  @override
  Future<Result<String>> call(StartRegistrationParams params) {
    return repository.startRegistration(email: params.email);
  }
}
