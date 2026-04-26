class CampaignEntity {
  final String id;
  final String title;
  final String description;
  final String image;
  final String category;
  final String status;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  final DateTime startDate;
  final DateTime endDate;

  CampaignEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.status,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.startDate,
    required this.endDate,
  });

  CampaignEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? category,
    String? status,
    double? rateValue,
    String? collectedValue,
    String? allValue,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CampaignEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
      status: status ?? this.status,
      rateValue: rateValue ?? this.rateValue,
      collectedValue: collectedValue ?? this.collectedValue,
      allValue: allValue ?? this.allValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
