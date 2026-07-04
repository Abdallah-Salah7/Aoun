import '../../data/data_sources/recommend_api_service.dart';
import '../../data/models/recommend_case_model.dart';
import '../../domain/entities/recommend_case_entity.dart';


class RecommendRepository {
  final RecommendApiService api;

  RecommendRepository(this.api);

  Future<List<RecommendCaseEntity>> getRecommendCases(
      String userId,
      ) async {
    final response = await api.getRecommendCases(
      userId: userId,
    );

    final List data = response.data;

    return data
        .map((e) => RecommendCaseModel.fromJson(e))
        .toList();
  }
}