import '../../domain/entities/donation_entity.dart';

class DonationModel {
  final String userName;
  final double amount;
  final DateTime date;

  DonationModel({
    required this.userName,
    required this.amount,
    required this.date,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      userName: json['userName'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  DonationEntity toEntity() {
    return DonationEntity(
      userName: userName,
      amount: amount,
      date: date,
    );
  }
}