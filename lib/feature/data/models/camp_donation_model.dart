class CampDonationModel {
  final String donorName;
  final double amount;
  final DateTime date;

  CampDonationModel({required this.donorName, required this.amount, required this.date});

  factory CampDonationModel.fromJson(Map<String, dynamic> json) {
    return CampDonationModel(
      donorName: json['donorName'] ?? "متبرع كريم",
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}