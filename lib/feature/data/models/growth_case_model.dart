import '../../domain/entities/growth_case_entity.dart';

class GrowthCaseModel {
  final String date;
  final double amount;

  GrowthCaseModel({
    required this.date,
    required this.amount,
  });
  factory GrowthCaseModel.fromJson(Map<String, dynamic> json) {
    return GrowthCaseModel(
      date: json['label'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }

  GrowthCaseEntity toEntity() {
    return GrowthCaseEntity(
      date: date,
      amount: amount,
    );
  }
}