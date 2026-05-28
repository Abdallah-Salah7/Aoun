import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',

      headers: {'Content-Type': 'application/json'},
    ),
  );

  ///register
  static Future<Response> register({required Map<String, dynamic> data}) async {
    return await dio.post('/api/Auth/register', data: data);
  }

  ///login
  static Future<Response> login({required Map<String, dynamic> data}) async {
    return await dio.post('/api/Auth/login', data: data);
  }

  ///get donor token
  static Future<String?> getDonorToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("donorToken");
  }

  ///get admin token
  static Future<String?> getAdminToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("adminToken");
  }
}