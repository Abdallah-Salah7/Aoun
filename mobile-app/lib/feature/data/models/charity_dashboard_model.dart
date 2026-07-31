import '../../domain/entities/dashboard_entity.dart';
import '../../domain/entities/growth_entity.dart';
import '../../domain/entities/recent_donation_entity.dart';
import '../../domain/entities/category_distribution_entity.dart';
import '../../domain/entities/top_donor_entity.dart';

class CharityDashboardModel extends DashboardEntity {
  CharityDashboardModel({
    required num totalDonations,
    required num totalDonors,
    required num totalCases,
    required num totalCampaigns,
    required num emergencyFundBalance,
    required List<GrowthEntity> weeklyGrowth,
    required List<RecentDonationEntity> recentDonationStatistic,
    required List<CategoryDistributionEntity> categoryDistribution,
    required List<TopDonorEntity> topDonors,
    required List<TopDonorEntity> allDonors,
    required List<GrowthEntity> weeklyDonorsGrowth,
    required List<GrowthEntity> monthlyDonorsGrowth,
    required List<GrowthEntity> monthlyGrowth,
    required num todayDonations,
    required num monthlyGrowthPercent,
    required num lastMonthTotal,
    required num thisMonthTotal,
  }) : super(
    monthlyGrowth: monthlyGrowth,
    totalDonations: totalDonations,
    totalDonors: totalDonors,
    totalCases: totalCases,
    totalCampaigns: totalCampaigns,
    emergencyFundBalance: emergencyFundBalance,
    weeklyGrowth: weeklyGrowth,
    recentDonationStatistic: recentDonationStatistic,
    categoryDistribution: categoryDistribution,
    topDonors: topDonors,
    allDonors: allDonors,
    weeklyDonorsGrowth: weeklyDonorsGrowth,
    monthlyDonorsGrowth: monthlyDonorsGrowth,
    todayDonations: todayDonations,
    monthlyGrowthPercent: monthlyGrowthPercent,
    lastMonthTotal: lastMonthTotal,
    thisMonthTotal: thisMonthTotal,
  );

  factory CharityDashboardModel.fromJson(Map<String, dynamic> json) {
    return CharityDashboardModel(
      totalDonations: (json['totalDonations'] as num?) ?? 0,
      totalDonors: (json['totalDonors'] as num?) ?? 0,
      totalCases: (json['totalCases'] as num?) ?? 0,
      totalCampaigns: (json['totalCampaigns'] as num?) ?? 0,
      emergencyFundBalance: (json['emergencyFundBalance'] as num?) ?? 0,

      weeklyGrowth: (json['weeklyGrowth'] as List?)
          ?.map((e) => GrowthEntity.fromJson(e))
          .toList() ??
          [],

      recentDonationStatistic: (json['recentDonationStatistic'] as List?)
          ?.map((e) => RecentDonationEntity.fromJson(e))
          .toList() ??
          [],

      categoryDistribution: (json['categoryDistribution'] as List?)
          ?.map((e) => CategoryDistributionEntity.fromJson(e))
          .toList() ??
          [],

      topDonors: (json['topDonors'] as List?)
          ?.map((e) => TopDonorEntity.fromJson(e))
          .toList() ??
          [],

      allDonors: (json['allDonors'] as List?)
          ?.map((e) => TopDonorEntity.fromJson(e))
          .toList() ??
          [],

      weeklyDonorsGrowth: (json['weeklyDonorsGrowth'] as List?)
          ?.map((e) => GrowthEntity.fromJson(e))
          .toList() ??
          [],

      monthlyDonorsGrowth: (json['monthlyDonorsGrowth'] as List?)
          ?.map((e) => GrowthEntity.fromJson(e))
          .toList() ??
          [],

      monthlyGrowth: (json['monthlyGrowth'] as List?)
          ?.map((e) => GrowthEntity.fromJson(e))
          .toList() ??
          [],

      todayDonations: (json['todayDonations'] as num?) ?? 0,
      monthlyGrowthPercent: (json['monthlyGrowthPercent'] as num?) ?? 0,
      lastMonthTotal: (json['lastMonthTotal'] as num?) ?? 0,
      thisMonthTotal: (json['thisMonthTotal'] as num?) ?? 0,
    );
  }
}