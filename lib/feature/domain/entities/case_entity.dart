class CaseEntity {
  final String id;
  final String title;
  final String description;
  final String image;
  final String category;
  final String status;
  final double rateValue;
  final String collectedValue;
  final String allValue;

  CaseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.status,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
  });

  CaseEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? category,
    String? status,
    double? rateValue,
    String? collectedValue,
    String? allValue,
  }) {
    return CaseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
      status: status ?? this.status,
      rateValue: rateValue ?? this.rateValue,
      collectedValue: collectedValue ?? this.collectedValue,
      allValue: allValue ?? this.allValue,
    );
  }
}
