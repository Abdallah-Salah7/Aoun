import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharityService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
    ),
  );

  Future<Map<String, dynamic>> getCharityStatus() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("charityToken");

    final response = await dio.get(
      '/api/Charity/status',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data;
  }
}