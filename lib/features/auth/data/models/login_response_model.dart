import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';

/// Data-layer DTO for the `POST /auth/login` response body (shaped after
/// dummyjson.com's demo auth API). Maps to the domain [AuthUser] via
/// [toEntity] — nothing outside `data/` should touch this class directly.
class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;

  const LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'image': image,
  };

  AuthUser toEntity() {
    final fullName = [
      firstName,
      lastName,
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ');

    return AuthUser(
      id: id ?? 0,
      name: fullName.isNotEmpty ? fullName : (username ?? ''),
      email: email ?? '',
      token: accessToken ?? '',
      // Placeholder — dummyjson has no concept of our roles. The repository
      // overwrites this with the real, locally-tracked role right after.
      role: UserRole.member,
    );
  }
}
