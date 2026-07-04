class CharityDashboardModel {
  final int totalDonations;
  final int totalDonors;
  final int totalCases;
  final int totalCampaigns;
  final int emergencyFundBalance;
  final int todayDonations;
  final double monthlyGrowthPercent;
  final int lastMonthTotal;
  final int thisMonthTotal;

  final List<GrowthModel> weeklyGrowth;
  final List<GrowthModel> monthlyGrowth;
  final List<CategoryDistributionModel> categoryDistribution;
  final List<DonorModel> topDonors;
  final List<DonorModel> allDonors;

  CharityDashboardModel({
    required this.totalDonations,
    required this.totalDonors,
    required this.totalCases,
    required this.totalCampaigns,
    required this.emergencyFundBalance,
    required this.todayDonations,
    required this.monthlyGrowthPercent,
    required this.lastMonthTotal,
    required this.thisMonthTotal,
    required this.weeklyGrowth,
    required this.monthlyGrowth,
    required this.categoryDistribution,
    required this.topDonors,
    required this.allDonors,
  });

  factory CharityDashboardModel.fromJson(Map<String, dynamic> json) {
    return CharityDashboardModel(
      totalDonations: json["totalDonations"] ?? 0,
      totalDonors: json["totalDonors"] ?? 0,
      totalCases: json["totalCases"] ?? 0,
      totalCampaigns: json["totalCampaigns"] ?? 0,
      emergencyFundBalance: json["emergencyFundBalance"] ?? 0,
      todayDonations: json["todayDonations"] ?? 0,
      monthlyGrowthPercent: (json["monthlyGrowthPercent"] ?? 0).toDouble(),
      lastMonthTotal: json["lastMonthTotal"] ?? 0,
      thisMonthTotal: json["thisMonthTotal"] ?? 0,

      weeklyGrowth:
          (json["weeklyGrowth"] as List)
              .map((e) => GrowthModel.fromJson(e))
              .toList(),

      monthlyGrowth:
          (json["monthlyGrowth"] as List)
              .map((e) => GrowthModel.fromJson(e))
              .toList(),

      categoryDistribution:
          (json["categoryDistribution"] as List)
              .map((e) => CategoryDistributionModel.fromJson(e))
              .toList(),

      topDonors:
          (json["topDonors"] as List)
              .map((e) => DonorModel.fromJson(e))
              .toList(),

      allDonors:
          (json["allDonors"] as List)
              .map((e) => DonorModel.fromJson(e))
              .toList(),
    );
  }
}

class GrowthModel {
  final String date;
  final double amount;

  GrowthModel({required this.date, required this.amount});

  factory GrowthModel.fromJson(Map<String, dynamic> json) {
    return GrowthModel(
      date: json["date"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
    );
  }
}

class CategoryDistributionModel {
  final String category;
  final double amount;

  CategoryDistributionModel({required this.category, required this.amount});

  factory CategoryDistributionModel.fromJson(Map<String, dynamic> json) {
    return CategoryDistributionModel(
      category: json["category"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
    );
  }
}

class DonorModel {
  final String name;
  final double amount;
  final String? imageUrl;

  DonorModel({required this.name, required this.amount, this.imageUrl});

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      name: json["name"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
      imageUrl: json["imageUrl"],
    );
  }
}
