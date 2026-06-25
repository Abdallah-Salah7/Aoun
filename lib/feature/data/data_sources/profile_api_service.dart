import 'package:dio/dio.dart';

import 'api_services.dart';

class ProfileApiService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://aounplatform.runasp.net",
    ),
  );


  Future<Map<String, dynamic>> getActivity() async {
    final token = await ApiServices.getDonorToken();
    final response = await _dio.get(
      "/api/Profile/activity",
      options: Options(
        headers: {"Authorization": "Bearer $token"},

      ),
    );

    return response.data;
  }
}