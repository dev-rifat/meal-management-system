import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mass_management/core/error/exceptions.dart';

/// Thin wrapper around [http.Client] that turns transport/status failures
/// into typed [Exception]s so data sources don't each re-implement this.
///
/// Currently only auth's remote data source uses this — every other
/// feature is backed by an in-memory local data source, not a real API
/// yet, so this stays feature-agnostic in `core/` for when they are.
class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(Uri url, {required Map<String, dynamic> body}) async {
    try {
      final response = await _client.post(
        url,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _decode(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  Future<Map<String, dynamic>> get(Uri url) async {
    try {
      final response = await _client.get(url);
      return _decode(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  Map<String, dynamic> _decode(http.Response response) {
    final decoded = response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);
    if (response.statusCode == 401) {
      throw const UnauthenticatedException();
    }
    if (response.statusCode == 404) {
      throw const NotFoundException();
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic> ? decoded['message']?.toString() : null;
      throw ServerException(message ?? 'Request failed with status ${response.statusCode}.');
    }
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }
}
