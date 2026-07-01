import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/admin_stats_model.dart';
import '../models/charity_model.dart';
import '../models/top_charity_model.dart';
import 'api_services.dart';

class AdminRemoteDataSource {
  final Dio dio;

  AdminRemoteDataSource(this.dio) {
    dio.options.baseUrl = 'https://aounplatform.runasp.net';
  }
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("adminToken");
  }

  Future<AdminStatsModel> getAdminStats() async {
    final token = await _getToken();

    print("Admin Token: $token");

    final response = await dio.get(
      '/api/Admin/stats',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return AdminStatsModel.fromJson(
      response.data['data'],
    );
  }


  Future<List<TopCharityModel>> getTopCharities() async {
    final token = await _getToken();

    final response = await dio.get(
      '/api/Admin/top-charities',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return (response.data['data'] as List)
        .map((e) => TopCharityModel.fromJson(e))
        .toList();
  }

  Future<List<CharityModel>> getPendingCharities() async {
    final token = await _getToken();

    final response = await dio.get(
      '/api/Admin/charities',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List data = response.data['data'];

    return data
        .map((e) => CharityModel.fromJson(e))
        .where((charity) => charity.status == "Pending")
        .toList();
  }

  Future<List<CharityModel>> getAcceptCharities() async {
    final token = await _getToken();

    final response = await dio.get(
      '/api/Admin/charities',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List data = response.data['data'];

    return data
        .map((e) => CharityModel.fromJson(e))
        .where((charity) => charity.status == "Approved")
        .toList();
  }

  Future<List<CharityModel>> getRejectedCharities() async {
    final token = await _getToken();

    final response = await dio.get(
      '/api/Admin/charities',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List data = response.data['data'];

    return data
        .map((e) => CharityModel.fromJson(e))
        .where((charity) => charity.status == "Rejected")
        .toList();
  }
}