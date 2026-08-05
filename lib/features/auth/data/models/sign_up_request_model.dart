/// Data-layer DTO backing the sign-up form. There is no real sign-up
/// endpoint yet (see [AuthLocalDataSource]), so this currently only shapes
/// the values passed to the in-memory registration flow.
class SignUpRequestModel {
  final String email;
  final String username;
  final String password;

  const SignUpRequestModel({
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
      };
}
