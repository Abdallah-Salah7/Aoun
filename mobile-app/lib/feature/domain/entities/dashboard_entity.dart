import 'package:aoun/feature/domain/entities/category_distribution_entity.dart';
import 'package:aoun/feature/domain/entities/top_donor_entity.dart';
import 'package:aoun/feature/domain/entities/growth_entity.dart';
import 'package:aoun/feature/domain/entities/recent_donation_entity.dart';

class DashboardEntity {
  final num totalDonations;
  final num totalDonors;
  final num totalCases;
  final num totalCampaigns;
  final num emergencyFundBalance;

  final List<GrowthEntity> weeklyGrowth;
  final List<GrowthEntity> monthlyGrowth;

  final List<CategoryDistributionEntity> categoryDistribution;

  final List<RecentDonationEntity> recentDonationStatistic;

  final List<TopDonorEntity> topDonors;
  final List<TopDonorEntity> allDonors;

  final List<GrowthEntity> weeklyDonorsGrowth;
  final List<GrowthEntity> monthlyDonorsGrowth;

  final num todayDonations;
  final num monthlyGrowthPercent;
  final num lastMonthTotal;
  final num thisMonthTotal;

  DashboardEntity({
    required this.totalDonations,
    required this.totalDonors,
    required this.totalCases,
    required this.totalCampaigns,
    required this.emergencyFundBalance,
    required this.weeklyGrowth,
    required this.monthlyGrowth,
    required this.categoryDistribution,
    required this.recentDonationStatistic,
    required this.topDonors,
    required this.allDonors,
    required this.weeklyDonorsGrowth,
    required this.monthlyDonorsGrowth,
    required this.todayDonations,
    required this.monthlyGrowthPercent,
    required this.lastMonthTotal,
    required this.thisMonthTotal,
  });
}