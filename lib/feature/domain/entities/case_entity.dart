import '../../domain/entities/case_entity.dart';

class CaseEntity {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final double progress;
  final bool isUrgent;
  final bool isCompleted;
  final int categoryId;
  final String status;
  final int donorCount;

  CaseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.progress,
    required this.isUrgent,
    required this.isCompleted,
    required this.categoryId,
    required this.status,
    required this.donorCount,
  });

  CaseEntity copyWith({
    int? id,
    int? donorCount,
    String? title,
    String? description,
    String? imageUrl,
    double? requiredAmount,
    double? collectedAmount,
    double? progress,
    bool? isUrgent,
    bool? isCompleted,
    int? categoryId,
    String? status,
  }) {
    return CaseEntity(
      id: id ?? this.id,
      donorCount: donorCount ?? this.donorCount,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      requiredAmount: requiredAmount ?? this.requiredAmount,
      collectedAmount: collectedAmount ?? this.collectedAmount,
      progress: progress ?? this.progress,
      isUrgent: isUrgent ?? this.isUrgent,
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
    );
  }
}
