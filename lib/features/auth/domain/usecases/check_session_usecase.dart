import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

/// Returns the currently signed-in [AuthUser], or `null` (wrapped in a
/// successful [Result]) when there is no active session — this is not an
/// error case.
class CheckSessionUseCase implements UseCase<AuthUser?, NoParams> {
  final AuthRepository repository;

  const CheckSessionUseCase(this.repository);

  @override
  Future<Result<AuthUser?>> call(NoParams params) {
    return repository.getCurrentSession();
  }
}
