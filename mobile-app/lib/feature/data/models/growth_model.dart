import '../../domain/entities/growth_entity.dart';

class GrowthModel {
  final String date;
  final num amount;

  GrowthModel({
    required this.date,
    required this.amount,
  });

  factory GrowthModel.fromJson(Map<String, dynamic> json) {
    return GrowthModel(
      date: json['date'] ?? '',
      amount: (json['amount'] as num?) ?? 0,
    );
  }

  GrowthEntity toEntity() {
    return GrowthEntity(
      date: date,
      amount: amount,
    );
  }
}