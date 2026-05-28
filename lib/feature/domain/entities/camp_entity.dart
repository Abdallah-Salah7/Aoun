import '../../data/models/camp_donation_model.dart';

class CampaignEntity {
  final int id;
  final String title;
  final String imageUrl;
  final String description; // تم إضافته
  final double requiredAmount;
  final double collectedAmount;
  final int donorsCount;
  final int daysLeft;
  final bool isCompleted;
  final DateTime startDate; // تم إضافته
  final DateTime endDate;   // تم إضافته
// أضيفي هذه الحقول
  final List<CampDonationModel> weeklyDonations;
  final List<CampDonationModel> monthlyDonations;
  final List<CampDonationModel> lastDonations;
  double get rateValue {
    if (requiredAmount <= 0) return 0.0;
    return (collectedAmount / requiredAmount).clamp(0.0, 1.0);
  }

  CampaignEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.donorsCount,
    required this.daysLeft,
    required this.isCompleted,
    required this.startDate,
    required this.endDate,
    this.weeklyDonations = const [],
    this.monthlyDonations = const [],
    this.lastDonations = const [],
  });

  // إضافة copyWith لتسهيل عملية التحديث في الـ UI
  CampaignEntity copyWith({
    String? title,
    String? description,
    String? allValue,
    String? category,
    String? status,
    String? image,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CampaignEntity(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: image ?? this.imageUrl,
      requiredAmount: allValue != null ? double.tryParse(allValue) ?? this.requiredAmount : this.requiredAmount,
      collectedAmount: this.collectedAmount,
      donorsCount: this.donorsCount,
      daysLeft: this.daysLeft,
      isCompleted: this.isCompleted,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}