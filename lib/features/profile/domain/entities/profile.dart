import 'package:equatable/equatable.dart';

/// Domain-level representation of the currently logged-in user's own
/// profile. Deliberately distinct from `Member` (features/members) which
/// models OTHER mess members from the current user's point of view — these
/// are two different concepts that happen to share some field names.
class Profile extends Equatable {
  final String name;
  final String email;
  final String profileImage;
  final String phoneNumber;
  final DateTime joiningDate;
  final DateTime birthday;
  final String emergencyContact;

  const Profile({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.phoneNumber,
    required this.joiningDate,
    required this.birthday,
    required this.emergencyContact,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        profileImage,
        phoneNumber,
        joiningDate,
        birthday,
        emergencyContact,
      ];
}
