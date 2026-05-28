import '../../domain/entities/donor_entity.dart';

class DonorModel {
  final String donorName;
  final num totalAmount;
  final num donationsCount;

  DonorModel({
    required this.donorName,
    required this.totalAmount,
    required this.donationsCount,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      donorName: json['donorName'] ?? '',
      totalAmount: (json['totalAmount'] as num?) ?? 0,
      donationsCount: (json['donationsCount'] as num?) ?? 0,
    );
  }

  DonorEntity toEntity() {
    return DonorEntity(
      donorName: donorName,
      totalAmount: totalAmount,
      donationsCount: donationsCount,
    );
  }
}