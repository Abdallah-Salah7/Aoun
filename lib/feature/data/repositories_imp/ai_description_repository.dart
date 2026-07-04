import '../../domain/entities/ai_description_entity.dart';
import '../data_sources/ai_description_api_service.dart';
import '../models/ai_description_request_model.dart';
import '../models/ai_description_response_model.dart';


class AiDescriptionRepository {
  final AiDescriptionApiService api;

  AiDescriptionRepository(this.api);

  Future<AiDescriptionEntity> generateDescription(
      AiDescriptionRequest request,
      ) async {
    final response = await api.generateDescription(request);

    return AiDescriptionResponse.fromJson(response.data);
  }
}