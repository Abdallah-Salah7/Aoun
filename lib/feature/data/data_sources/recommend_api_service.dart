import 'package:dio/dio.dart';

class RecommendApiService {
  final Dio dio;

  RecommendApiService(this.dio);

  Future<Response> getRecommendCases({
    required String userId,
  }) async {
    return await dio.post(
      "https://abdallah-salah-aoun-ai-engine.hf.space/api/ai/recommend",
      data: {
        "userId": userId,
      },
    );
  }
}