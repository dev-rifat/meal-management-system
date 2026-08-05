/// Data-layer DTO for the `POST /auth/login` request body. Not a domain
/// entity — kept here purely to shape the JSON we send.
class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
