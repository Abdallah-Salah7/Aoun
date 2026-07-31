import '../../domain/entities/category_distribution_entity.dart';

class CategoryDistributionModel {
  final String categoryName;
  final double amount;
  final double percentage;

  CategoryDistributionModel({
    required this.categoryName,
    required this.amount,
    required this.percentage,
  });

  factory CategoryDistributionModel.fromJson(Map<String, dynamic> json) {
    return CategoryDistributionModel(
      categoryName: json['categoryName'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }

  CategoryDistributionEntity toEntity() {
    return CategoryDistributionEntity(
      categoryName: categoryName,
      amount: amount,
      percentage: percentage,
    );
  }
}