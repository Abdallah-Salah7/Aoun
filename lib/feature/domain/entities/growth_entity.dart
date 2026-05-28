class GrowthEntity {
  final String date;
  final num amount;

  GrowthEntity({
    required this.date,
    required this.amount,
  });

  factory GrowthEntity.fromJson(Map<String, dynamic> json) {
    return GrowthEntity(
      date: json['date'] ?? '',
      amount: (json['amount'] as num?) ?? 0,
    );
  }
}