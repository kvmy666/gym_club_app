import 'package:dio/dio.dart';

import '../api/api_client.dart';

class AuthApi {
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? gender,
  }) async {
    final res = await ApiClient.http.post('/auth/register', data: {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
    });
    return res.data as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final res = await ApiClient.http.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return res.data as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> me(String token) async {
    final res = await ApiClient.http.get(
      '/auth/me',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return res.data as Map<String, dynamic>;
  }
}
