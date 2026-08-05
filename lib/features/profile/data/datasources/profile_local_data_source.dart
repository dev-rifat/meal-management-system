import 'package:mass_management/features/profile/domain/entities/profile.dart';

/// Purely in-memory demo data. There is no persistence package or backend
/// endpoint wired up for the current user's own profile yet, so this always
/// returns the same seeded "John Doe" values — an accepted limitation for
/// this pass. Do not add a new dependency to work around it here; that
/// belongs to a dedicated persistence/backend integration pass.
abstract class ProfileLocalDataSource {
  Future<Profile> getCurrentProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Profile _seededProfile = Profile(
    name: "John Doe",
    email: "john.doe@example.com",
    profileImage: "https://i.pravatar.cc/150?img=5",
    phoneNumber: "+880123456789",
    joiningDate: DateTime(2023, 4, 20),
    birthday: DateTime(1995, 7, 15),
    emergencyContact: "+880987654321",
  );

  @override
  Future<Profile> getCurrentProfile() async {
    return _seededProfile;
  }
}
