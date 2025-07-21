import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mass_management/features/auth/auth.dart';

class AuthRepository {
  login(String userName, String password) async {
    {
      Uri url = Uri.parse('https://dummyjson.com/auth/login');

      LoginReqModel reqModel = LoginReqModel(
        username: userName,
        password: password,
      );

      http.Response res = await http.post(
        url,
        body: jsonEncode(reqModel.toJson()),
      );

      if (res.statusCode == 200) {
        return LoginResModel.fromJson(jsonDecode(res.body));
      } else {
        return LoginResModel();
      }
    }
  }
}
