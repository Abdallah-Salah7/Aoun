import '../../domain/entities/donor_case_entity.dart';

class DonorCaseModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final bool isUrgent;

  DonorCaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.isUrgent,
  });

  factory DonorCaseModel.fromJson(Map<String, dynamic> json) {
    return DonorCaseModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      requiredAmount: (json["requiredAmount"] ?? 0).toDouble(),
      collectedAmount: (json["collectedAmount"] ?? 0).toDouble(),
      isUrgent: json["isUrgent"] ?? false,
    );
  }

  DonorCaseEntity toEntity() {
    return DonorCaseEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      requiredAmount: requiredAmount,
      collectedAmount: collectedAmount,
      isUrgent: isUrgent,
    );
  }
}