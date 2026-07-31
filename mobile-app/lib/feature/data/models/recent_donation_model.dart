import '../../domain/entities/recent_donation_entity.dart';

class RecentDonationModel {
  final String donorName;
  final num amount;
  final String targetName;
  final String date;

  RecentDonationModel({
    required this.donorName,
    required this.amount,
    required this.targetName,
    required this.date,
  });

  factory RecentDonationModel.fromJson(Map<String, dynamic> json) {
    return RecentDonationModel(
      donorName: json['donorName'] ?? '',
      amount: (json['amount'] as num?) ?? 0,
      targetName: json['targetName'] ?? '',
      date: json['date'] ?? '',
    );
  }

  RecentDonationEntity toEntity() {
    return RecentDonationEntity(
      donorName: donorName,
      amount: amount,
      targetName: targetName,
      date: DateTime.tryParse(date) ?? DateTime(1970),
    );
  }
}