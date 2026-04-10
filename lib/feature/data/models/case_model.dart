import '../../domain/entities/case_entity.dart';

class CaseModel extends CaseEntity {
  CaseModel({
    required super.image,
    required super.title,
    required super.description,
    required super.rateValue,
    required super.collectedValue,
    required super.allValue,
    required super.status,
    required super.category,
  });

  factory CaseModel.fromMap(Map<String, dynamic> map) {
    return CaseModel(
      image: map["image"],
      title: map["title"],
      description: map["description"],
      rateValue: map["rateValue"],
      collectedValue: map["collectedValue"],
      allValue: map["allValue"],
      status: map["status"],
      category: map["category"],
    );
  }
}