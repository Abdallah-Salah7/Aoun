import 'dart:io';

import 'package:dio/dio.dart';

class CampApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {
        'accept': '*/*',
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODE5ODUxMzMsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.kb9GBY4SnEbD2aXBmDi_AUdC0VHH84tJ8sWVh4Oo-4Q"
      },
    ),
  );

  Future<Response> getCampaignsByCharity(int charityId) async {
    return await dio.get(
      '/api/Campaigns/charity/$charityId',
      queryParameters: {
        'status': 'all',
        'page': 1,
        'pageSize': 10,
      },
    );
  }

  Future<Response> getCampaignDetails(int campaignId) async {
    return await dio.get(
      '/api/Campaigns/charity/details/$campaignId',
    );
  }


  Future<Response> updateCampaign(int id, FormData formData) async {
    print("FIELDS:");
    print(formData.fields);

    print("FILES:");
    print(formData.files);

    try {
      final response = await dio.put(
        "/api/Campaigns/$id",
        data: formData,
        options: Options(
          headers: {
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
  }  Future<Response> addCampaign(FormData formData) async {
    return await dio.post(
      "/api/Campaigns",
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }

  Future<Response> deleteCampaign(int id) async {
    return await dio.delete("/api/Campaigns/$id");
  }

}