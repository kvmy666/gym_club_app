import 'package:dio/dio.dart';

import 'api_config.dart';

class ApiClient {
  ApiClient._internal()
      : dio = Dio(
          BaseOptions(
            baseUrl: apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 20),
          ),
        );

  static final ApiClient _instance = ApiClient._internal();
  static Dio get http => _instance.dio;

  final Dio dio;

  static void setAuthToken(String? token) {
    if (token == null) {
      _instance.dio.options.headers.remove('Authorization');
    } else {
      _instance.dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
