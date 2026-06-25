import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {
        'accept': '*/*',
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3ODQ0ODQsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.mfvNzj_pSKI9Zu7dhcyzoYCICT5MU9CXBOikYZXzvjI"
      },
    ),
  );
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("charityToken");
  }

  Future<Options> getOptions() async {
    final token = await _getToken();

    return Options(
      headers: {
        "accept": "*/*",
        "Authorization": "Bearer $token",
      },
    );
  }

  Future<Response> getCampaignsByCharity(int charityId) async {

    return await dio.get(
      '/api/Campaigns/charity/$charityId',
      queryParameters: {
        'status': 'all',
        'page': 1,
        'pageSize': 20,
      },
      options: await getOptions(),
    );
  }


  Future<Response> getCampaignDetails(int campaignId) async {
    print("CAMPAIGN ID = $campaignId");

    try {
      final response = await dio.get(
        '/api/Campaigns/charity/details/$campaignId',
        options: await getOptions(),
      );

      print("DETAIL RESPONSE:");
      print(response.data);

      return response;
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");
      print("ERROR MESSAGE: ${e.message}");

      rethrow;
    }
  }


  Future<Response> updateCampaign(int id, FormData formData) async {
    final token = await _getToken();

    try {
      final response = await dio.put(
        "/api/Campaigns/$id",
        data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
      );

      print("SUCCESS:");
      print(response.data);

      return response;
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");
      print("ERROR MESSAGE: ${e.message}");

      rethrow;
    }
  }

  Future<Response> addCampaign(FormData formData) async {
    final token = await _getToken();

    print("TOKEN = $token");

    try {
      final response = await dio.post(
        "/api/Campaigns",
        data: formData,
        options: Options(
          headers: {
            "accept": "*/*",
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print("ADD CAMPAIGN SUCCESS:");
      print(response.data);

      return response;
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");
      print("ERROR MESSAGE: ${e.message}");

      rethrow;
    }
  }
  Future<Response> deleteCampaign(int id) async {
    return await dio.delete(
        "/api/Campaigns/$id");
  }

}