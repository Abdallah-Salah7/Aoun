import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorCaseApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://aounplatform.runasp.net",
      headers: {
        "accept": "*/*",
      },
    ),
  );

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<Options> getOptions() async {
    final token = await _getToken();

    return Options(
      headers: {
        "Authorization": "Bearer $token",
        "accept": "*/*",
      },
    );
  }

  Future<Response> getCases({
    required String categoryName,
    String status = "all",
    int page = 1,
    int pageSize = 20,
  }) async {
    return dio.get(
      "/api/Cases",
      queryParameters: {
        "categoryName": categoryName,
        "status": status,
        "page": page,
        "pageSize": pageSize,
      },
      options: await getOptions(),
    );
  }

  /// تفاصيل الحالة
  Future<Response> getCaseDetails(int id) async {
    return await dio.get(
      "/api/Cases/public/$id",
      options: await getOptions(),
    );
  }
}