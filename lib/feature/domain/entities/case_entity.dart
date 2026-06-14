import 'donation_entity.dart';
import 'growth_case_entity.dart';

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

  final int donorsCount;

  final DateTime? createdAt;
  final DateTime? completedAt;

  final String charityName;

  final List<DonationEntity> lastDonations;

  final List<GrowthCaseEntity> weeklyGrowth;
  final List<GrowthCaseEntity> monthlyGrowth;

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
    required this.donorsCount,
    required this.createdAt,
    required this.completedAt,
    required this.charityName,
    required this.lastDonations,
    required this.weeklyGrowth,
    required this.monthlyGrowth,
  });

  // ⭐ أهم إضافة في المشروع كله
  bool get isReallyCompleted =>
      progress >= 1.0 ||
          collectedAmount >= requiredAmount ||
          status == "مكتملة";

  CaseEntity copyWith({
    int? id,
    int? donorsCount,
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
    DateTime? createdAt,
    DateTime? completedAt,
    String? charityName,
    List<DonationEntity>? lastDonations,
    List<GrowthCaseEntity>? weeklyGrowth,
    List<GrowthCaseEntity>? monthlyGrowth,
  }) {
    return CaseEntity(
      id: id ?? this.id,
      donorsCount: donorsCount ?? this.donorsCount,
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
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      charityName: charityName ?? this.charityName,
      lastDonations: lastDonations ?? this.lastDonations,
      weeklyGrowth: weeklyGrowth ?? this.weeklyGrowth,
      monthlyGrowth: monthlyGrowth ?? this.monthlyGrowth,
    );
  }
}