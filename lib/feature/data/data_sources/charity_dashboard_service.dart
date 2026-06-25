import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/dashboard_repository.dart';
import '../models/charity_dashboard_model.dart';

class CharityDashboardService implements DashboardRepository {
  final Dio dio;

  CharityDashboardService(this.dio);

  @override
  Future<CharityDashboardModel> getDashboardStats() async {

    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("charityToken");

    print("TOKEN = $token");

    final response = await dio.get(
      'https://aounplatform.runasp.net/api/CharityDashboard',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
        },
      ),
    );

    return CharityDashboardModel.fromJson(response.data);
  }
}