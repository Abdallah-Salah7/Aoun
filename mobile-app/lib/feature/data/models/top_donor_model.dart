import '../../domain/entities/top_donor_entity.dart';

class TopDonorModel {
  final String donorName;
  final num totalAmount;
  final num donationsCount;

  TopDonorModel({
    required this.donorName,
    required this.totalAmount,
    required this.donationsCount,
  });

  factory TopDonorModel.fromJson(Map<String, dynamic> json) {
    return TopDonorModel(
      donorName: json['donorName'] ?? '',
      totalAmount: (json['totalAmount'] as num?) ?? 0,
      donationsCount: (json['donationsCount'] as num?) ?? 0,
    );
  }

  TopDonorEntity toEntity() {
    return TopDonorEntity(
      donorName: donorName,
      totalAmount: totalAmount,
      donationsCount: donationsCount,
    );
  }
}