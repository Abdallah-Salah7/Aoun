import 'package:dio/dio.dart';

import '../models/ai_description_request_model.dart';


class AiDescriptionApiService {
  final Dio dio;

  AiDescriptionApiService(this.dio);

  Future<Response> generateDescription(
      AiDescriptionRequest request,
      ) async {
    return await dio.post(
      "https://abdallah-salah-aoun-ai-engine.hf.space/api/ai/process-description",
      data: request.toJson(),
    );
  }
}