import '../../data/models/growth_camp_model.dart';
import '../../data/models/last_donation_model.dart';

class CampaignEntity {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double requiredAmount;
  final double collectedAmount;
  final int donorsCount;
  final int daysLeft;
  final bool isCompleted;
  final DateTime? startDate;
  final DateTime? endDate;

  final List<GrowthCampModel> weeklyCampDonations;
  final List<GrowthCampModel> monthlyCampDonations;
  final List<LastDonationModel> lastCampDonations;

  double get rateValue =>
      requiredAmount <= 0
          ? 0.0
          : (collectedAmount / requiredAmount).clamp(0.0, 1.0);

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
    this.weeklyCampDonations = const [],
    this.monthlyCampDonations = const [],
    this.lastCampDonations = const [],
  });
}