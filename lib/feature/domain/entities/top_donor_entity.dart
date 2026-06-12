class TopDonorEntity {
  final String donorName;
  final num totalAmount;
  final num donationsCount;

  TopDonorEntity({
    required this.donorName,
    required this.totalAmount,
    required this.donationsCount,
  });

  factory TopDonorEntity.fromJson(Map<String, dynamic> json) {
    return TopDonorEntity(
      donorName: json['donorName'] ?? '',
      totalAmount: (json['totalAmount'] as num?) ?? 0,
      donationsCount: (json['donationsCount'] as num?) ?? 0,
    );
  }
}