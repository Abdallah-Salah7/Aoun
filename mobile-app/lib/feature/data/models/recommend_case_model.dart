import '../../domain/entities/recommend_case_entity.dart';

class RecommendCaseModel extends RecommendCaseEntity {
  const RecommendCaseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.requiredAmount,
    required super.collectedAmount,
    required super.isUrgent,
  });

  factory RecommendCaseModel.fromJson(Map<String, dynamic> json) {
    return RecommendCaseModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      requiredAmount: (json['requiredAmount'] as num).toDouble(),
      collectedAmount: (json['collectedAmount'] as num).toDouble(),
      isUrgent: json['isUrgent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "requiredAmount": requiredAmount,
      "collectedAmount": collectedAmount,
      "isUrgent": isUrgent,
    };
  }
}