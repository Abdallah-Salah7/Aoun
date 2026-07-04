import '../../domain/entities/ai_description_entity.dart';

class AiDescriptionResponse extends AiDescriptionEntity {
  AiDescriptionResponse({
    required super.result,
  });

  factory AiDescriptionResponse.fromJson(Map<String, dynamic> json) {
    return AiDescriptionResponse(
      result: json["result"] ?? "",
    );
  }
}