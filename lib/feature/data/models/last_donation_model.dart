import '../../domain/entities/donation_entity.dart';

class LastDonationModel  {
  final String userName;
  final double amount;
  final DateTime date;

  LastDonationModel ({
    required this.userName,
    required this.amount,
    required this.date,
  });

  factory LastDonationModel .fromJson(Map<String, dynamic> json) {
    return LastDonationModel (
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