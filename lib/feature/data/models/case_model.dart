import '../../domain/entities/case_entity.dart';
import 'last_donation_model.dart';
import 'growth_case_model.dart';

class CaseModel {
  final int id;
  final int donorsCount;
  final String title;
  final String description;
  final String imageUrl;
  final String status;
  final int categoryId;
  final String categoryName;
  final double requiredAmount;
  final double collectedAmount;
  final bool isUrgent;
  final bool isCompleted;
  final double progress;
  final DateTime? createdAt;
  final DateTime? completedAt;
  final String charityName;
  final List<LastDonationModel> lastDonations;
  final List<GrowthCaseModel> weeklyGrowth;
  final List<GrowthCaseModel> monthlyGrowth;



  CaseModel({
    required this.id,
    required this.donorsCount,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.categoryId,
    required this.categoryName,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.isUrgent,
    required this.isCompleted,
    required this.progress,
    required this.createdAt,
    required this.completedAt,
    required this.charityName,
    required this.lastDonations,
    required this.weeklyGrowth,
    required this.monthlyGrowth,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    final String serverCategoryName = json['categoryName'] ?? "";
    int extractedCategoryId = json['categoryId'] ?? 0;
    if (extractedCategoryId == 0 && serverCategoryName.isNotEmpty) {
      final Map<String, int> categoriesIdsMap = {
        "الصحة": 1,
        "التعليم": 2,
        "الإغاثة": 3,
        "كفالات": 4,
        "مشاريع بناء": 5,
        "التنمية": 6,
        "ذوى الاحتياجات": 7,
        "ذوي الاحتياجات": 7,
        "كفارات": 8,
        "الغارمين": 9,
        "الإطعام": 10,
      };

      final cleanName = serverCategoryName.trim();
      extractedCategoryId = categoriesIdsMap[cleanName] ?? 0;
    }
    final double reqAmount = (json['requiredAmount'] ?? 0).toDouble();
    final double colAmount = (json['collectedAmount'] ?? 0).toDouble();
    final double calculatedProgress = (reqAmount == 0) ? 0.0 : (colAmount / reqAmount);

    return CaseModel(
      id: json['id'] ?? 0,
      donorsCount: json['donorsCount'] ?? 0,

      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      status: json['status'] ?? "",

      categoryId: extractedCategoryId,
      categoryName: serverCategoryName,

      requiredAmount: reqAmount,
      collectedAmount: colAmount,

      progress: json['progress']?.toDouble() ?? calculatedProgress,

      isUrgent: json['isUrgent'] ?? false,
      isCompleted: json['isCompleted'] ?? false,

      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,

      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,

      charityName: json['charityName'] ?? '',

      lastDonations: (json['lastDonations'] as List<dynamic>?)
          ?.map((e) => LastDonationModel.fromJson(e))
          .toList() ??
          [],

      weeklyGrowth: (json['weeklyDonations'] as List<dynamic>?)
          ?.map((e) => GrowthCaseModel.fromJson(e))
          .toList() ??
          [],

      monthlyGrowth: (json['monthlyDonations'] as List<dynamic>?)
          ?.map((e) => GrowthCaseModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  CaseEntity toEntity() {
    return CaseEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      status: status,
      categoryId: categoryId,
      requiredAmount: requiredAmount,
      collectedAmount: collectedAmount,
      isUrgent: isUrgent,
      isCompleted: isCompleted,
      progress: progress,
      donorsCount: donorsCount,

      createdAt: createdAt,
      completedAt: completedAt,
      charityName: charityName,

      lastDonations:
      lastDonations.map((e) => e.toEntity()).toList(),

      weeklyGrowth:
      weeklyGrowth.map((e) => e.toEntity()).toList(),

      monthlyGrowth:
      monthlyGrowth.map((e) => e.toEntity()).toList(),
    );
  }
}