import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/profile/domain/entities/profile.dart';
import 'package:mass_management/features/profile/domain/repositories/profile_repository.dart';

/// Returns the currently signed-in user's own [Profile].
class GetCurrentProfile implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  const GetCurrentProfile(this.repository);

  @override
  Future<Result<Profile>> call(NoParams params) {
    return repository.getCurrentProfile();
  }
}
