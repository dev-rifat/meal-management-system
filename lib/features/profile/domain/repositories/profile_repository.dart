import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/profile/domain/entities/profile.dart';

/// Contract the data layer must fulfil for anything profile-related. The
/// presentation layer (via the use cases) only ever talks to this interface.
abstract class ProfileRepository {
  Future<Result<Profile>> getCurrentProfile();
}
