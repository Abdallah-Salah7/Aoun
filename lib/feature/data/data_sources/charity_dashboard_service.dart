import 'package:dio/dio.dart';

import '../models/charity_dashboard_model.dart';
import '../../domain/repositories/dashboard_repository.dart';

class CharityDashboardService implements DashboardRepository {
  final Dio dio;

  CharityDashboardService(this.dio);

  @override
  Future<CharityDashboardModel> getDashboardStats() async {
    final response = await dio.get(
      'https://aounplatform.runasp.net/api/CharityDashboard',
      options: Options(
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODE5ODUxMzMsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.kb9GBY4SnEbD2aXBmDi_AUdC0VHH84tJ8sWVh4Oo-4Q"

          ,
      'accept': '*/*',
        },
      ),
    );
    // print(response.data);
    return CharityDashboardModel.fromJson(response.data);
  }
}