class CategoryDistributionEntity {
  final String categoryName;
  final double amount;
  final double percentage;

  CategoryDistributionEntity({
    required this.categoryName,
    required this.amount,
    required this.percentage,
  });

  factory CategoryDistributionEntity.fromJson(Map<String, dynamic> json) {
    return CategoryDistributionEntity(
      categoryName: json['categoryName'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}