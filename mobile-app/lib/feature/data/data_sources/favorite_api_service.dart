import 'package:dio/dio.dart';
import 'api_services.dart';

class FavoriteApiService {
  // =========================
  // CASES (الحالات)
  // =========================

  Future<List<dynamic>> getFavoriteCases() async {
    final token = await ApiServices.getDonorToken();

    final response = await ApiServices.dio.get(
      '/api/Favorites/cases',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    return response.data;
  }

  Future<void> addCaseToFavorites(int id) async {
    final token = await ApiServices.getDonorToken();

    try {
      final response = await ApiServices.dio.post(
        '/api/Favorites/case/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      print(response.data);
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("PATH: ${e.requestOptions.path}");
      print("TOKEN: $token");

      rethrow;
    }
  }

  Future<void> removeCaseFromFavorites(int id) async {
    final token = await ApiServices.getDonorToken();

    await ApiServices.dio.delete(
      '/api/Favorites/case/$id',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  // =========================
  // CAMPAIGNS (الحملات)
  // =========================

  Future<List<dynamic>> getFavoriteCampaigns() async {
    final token = await ApiServices.getDonorToken();

    final response = await ApiServices.dio.get(
      '/api/Favorites/campaigns',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    return response.data;
  }

  Future<void> addCampaignToFavorites(int id) async {
    final token = await ApiServices.getDonorToken();

    await ApiServices.dio.post(
      '/api/Favorites/campaign/$id',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  Future<void> removeCampaignFromFavorites(int id) async {
    final token = await ApiServices.getDonorToken();

    await ApiServices.dio.delete(
      '/api/Favorites/campaign/$id',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }
}