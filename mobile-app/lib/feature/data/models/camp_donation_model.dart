class CampDonationModel {
  final String donorName;
  final double amount;
  final DateTime date;

  CampDonationModel({
    required this.donorName,
    required this.amount,
    required this.date,
  });

  factory CampDonationModel.fromJson(Map<String, dynamic> json) {
    return CampDonationModel(
      donorName: json['donorName'] ?? "متبرع كريم",
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  // ✅ ضفنا دي عشان تتحل مشكلة toJson
  Map<String, dynamic> toJson() {
    return {
      "donorName": donorName,
      "amount": amount,
      "date": date.toIso8601String(),
    };
  }
}