import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorCampaignApiService {
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
    return prefs.getString("donorToken");
  }

  Future<Options> getOptions() async {
    final token = await _getToken();

    return Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  /// جميع الحملات
  Future<Response> getCampaigns({
    int page = 1,
    int pageSize = 10,
  }) async {
    return await dio.get(
      "/api/Campaigns/public",
      queryParameters: {
        "page": page,
        "pageSize": pageSize,
      },
      options: await getOptions(),
    );
  }

  /// تفاصيل حملة
  Future<Response> getCampaignDetails(int id) async {
    return await dio.get(
      "/api/Campaigns/$id",
      options: await getOptions(),
    );
  }
}