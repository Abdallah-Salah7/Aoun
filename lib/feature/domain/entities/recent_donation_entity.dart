class RecentDonationEntity {
  final String donorName;
  final num amount;
  final String targetName;
  final DateTime date;

  RecentDonationEntity({
    required this.donorName,
    required this.amount,
    required this.targetName,
    required this.date,
  });

  factory RecentDonationEntity.fromJson(Map<String, dynamic> json) {
    return RecentDonationEntity(
      donorName: json['donorName'] ?? '',
      amount: (json['amount'] as num?) ?? 0,
      targetName: json['targetName'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime(1970),
    );
  }
}