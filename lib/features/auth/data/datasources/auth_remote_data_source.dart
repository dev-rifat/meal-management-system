import 'package:mass_management/core/network/api_client.dart';
import 'package:mass_management/features/auth/data/models/login_request_model.dart';
import 'package:mass_management/features/auth/data/models/login_response_model.dart';

/// dummyjson.com is a public demo API used only as a stand-in login
/// backend — the project has no real mess-management auth service yet, so
/// this is a placeholder until one exists.
abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  static final Uri _loginUrl = Uri.parse('https://dummyjson.com/auth/login');

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final json = await apiClient.post(_loginUrl, body: request.toJson());
    return LoginResponseModel.fromJson(json);
  }
}
