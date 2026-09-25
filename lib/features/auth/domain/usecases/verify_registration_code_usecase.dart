import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class VerifyRegistrationCodeParams extends Equatable {
  final String accountRequestId;
  final String code;

  const VerifyRegistrationCodeParams({
    required this.accountRequestId,
    required this.code,
  });

  @override
  List<Object?> get props => [accountRequestId, code];
}

/// Verifies the emailed code. Returns a registration token needed for
/// [FinishRegistrationUseCase].
class VerifyRegistrationCodeUseCase
    implements UseCase<String, VerifyRegistrationCodeParams> {
  final AuthRepository repository;

  const VerifyRegistrationCodeUseCase(this.repository);

  @override
  Future<Result<String>> call(VerifyRegistrationCodeParams params) {
    return repository.verifyRegistrationCode(
      accountRequestId: params.accountRequestId,
      code: params.code,
    );
  }
}
