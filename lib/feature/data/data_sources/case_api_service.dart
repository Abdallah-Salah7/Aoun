import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {
        'accept': '*/*',
      },
    ),
  );
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("charityToken");
  }
  Future<Response> getCases() async {
    final prefs = await SharedPreferences.getInstance();

    final charityId =
    prefs.getInt("charityId");

    final token =
    prefs.getString("charityToken");

    return await dio.get(
      '/api/Cases/charity/$charityId/cases',
      queryParameters: {
        'status': 'all',
        'page': 1,
        'pageSize': 30,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> updateCase(
      int id,
      FormData data,
      ) async {
    print(data.fields);

    final token = await _getToken();

    return await dio.put(
      "/api/Cases/$id",
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
          "accept": "*/*",
        },
      ),
    );
  }


  Future<Response> getCaseById(int id) async {
    final token = await _getToken();

    return await dio.get(
      '/api/Cases/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> getPublicCaseById(int id) async {
    return await dio.get(
      '/api/Cases/public/$id',
      options: Options(
        validateStatus: (_) => true,
      ),
    );
  }

  Future<Response> deleteCase(int id) async {
    final token = await _getToken();

    return await dio.delete(
      '/api/Cases/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
        },
      ),
    );
  }

  Future<Response> addCase(FormData data) async {
    final token = await _getToken();

    return await dio.post(
      '/api/Cases',
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }
}