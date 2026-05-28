class DonorEntity {
  final String donorName;
  final num totalAmount;
  final num donationsCount;

  DonorEntity({
    required this.donorName,
    required this.totalAmount,
    required this.donationsCount,
  });

  factory DonorEntity.fromJson(Map<String, dynamic> json) {
    return DonorEntity(
      donorName: json['donorName'] ?? '',
      totalAmount: (json['totalAmount'] as num?) ?? 0,
      donationsCount: (json['donationsCount'] as num?) ?? 0,
    );
  }
}