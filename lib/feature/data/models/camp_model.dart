import 'camp_donation_model.dart';

class CampaignModel {
  final int id;
  final String title;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final int donorsCount;
  final int daysLeft;
  final int? completedInDays;
  final String? completedAt;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<CampDonationModel> weeklyDonations;
  final List<CampDonationModel> monthlyDonations;
  final List<CampDonationModel> lastDonations;
  final StatsModel stats;
  final int page;
  final int pageSize;
  final int totalCount;
  final List<CampaignModel> campaigns;
  double get rateValue {
    if (requiredAmount <= 0) return 0.0;
    return (collectedAmount / requiredAmount).clamp(0.0, 1.0);
  }


  CampaignModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.donorsCount,
    required this.daysLeft,
    this.completedInDays,
    this.completedAt,
    this.description,
    this.startDate,
    this.endDate,
    this.weeklyDonations = const [],
    this.monthlyDonations = const [],
    this.lastDonations = const [],
    required this.stats,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.campaigns,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'] ?? "",
      imageUrl: json['imageUrl']?.toString().startsWith('http') == true
          ? json['imageUrl']
          : "https://aounplatform.runasp.net${json['imageUrl']}",
      requiredAmount: (json['requiredAmount'] as num?)?.toDouble() ?? 0.0,
      collectedAmount: (json['collectedAmount'] as num?)?.toDouble() ?? 0.0,
      donorsCount: json['donorsCount'] ?? 0,
      daysLeft: json['daysLeft'] ?? 0,
      completedInDays: json['completedInDays'],
      completedAt: json['completedAt'],
      description: json['description'],
      startDate: json['startDate'] != null ? DateTime.tryParse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,

      weeklyDonations: json['weeklyDonations'] != null
          ? (json['weeklyDonations'] as List).map((e) => CampDonationModel.fromJson(e)).toList()
          : [],
      monthlyDonations: json['monthlyDonations'] != null
          ? (json['monthlyDonations'] as List).map((e) => CampDonationModel.fromJson(e)).toList()
          : [],
      lastDonations: json['lastDonations'] != null
          ? (json['lastDonations'] as List).map((e) => CampDonationModel.fromJson(e)).toList()
          : [],

      // التعديل هنا: إضافة شرط للتحقق من وجود الـ stats
      stats: json['stats'] != null
          ? StatsModel.fromJson(json['stats'])
          : StatsModel(totalDonations: 0, campaignsCount: 0, donorsCount: 0),

      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalCount: json['totalCount'] ?? 0,
      campaigns: json['campaigns'] != null
          ? (json['campaigns'] as List).map((i) => CampaignModel.fromJson(i)).toList()
          : [],
    );
  }
}
class StatsModel {
  final double totalDonations;
  final int campaignsCount;
  final int donorsCount;

  StatsModel({
    required this.totalDonations,
    required this.campaignsCount,
    required this.donorsCount,
  });
// في StatsModel - عدليها لتكون أكثر مرونة
  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalDonations: (json['totalDonations'] as num?)?.toDouble() ?? 0.0,
      campaignsCount: json['campaignsCount'] ?? 0,
      donorsCount: json['donorsCount'] ?? 0,
    );
  }
}