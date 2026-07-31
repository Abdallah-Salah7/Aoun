class GrowthCampModel {
  final String label;
  final double amount;

  GrowthCampModel({
    required this.label,
    required this.amount,
  });

  factory GrowthCampModel.fromJson(Map<String, dynamic> json) {
    return GrowthCampModel(
      label: json['label'],
      amount: (json['amount'] as num).toDouble(),
    );
  }
}