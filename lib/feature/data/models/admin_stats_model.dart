class AdminStatsModel {
  final int totalUsers;
  final int totalDonors;
  final int totalCases;
  final int totalCharities;
  final int approvedCharities;
  final int rejectedCharities;
  final int suspendedCharities;
  final int totalDonationsAmount;

  AdminStatsModel({
    required this.totalUsers,
    required this.totalDonors,
    required this.totalCases,
    required this.totalCharities,
    required this.approvedCharities,
    required this.rejectedCharities,
    required this.suspendedCharities,
    required this.totalDonationsAmount,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      totalUsers: (json['totalUsers'] as num).toInt(),
      totalDonors: (json['totalDonors'] as num).toInt(),
      totalCases: (json['totalCases'] as num).toInt(),
      totalCharities: (json['totalCharities'] as num).toInt(),
      approvedCharities: (json['approvedCharities'] as num).toInt(),
      rejectedCharities: (json['rejectedCharities'] as num).toInt(),
      suspendedCharities: (json['suspendedCharities'] as num).toInt(),
      totalDonationsAmount:
      (json['totalDonationsAmount'] as num).toInt(),
    );
  }
}