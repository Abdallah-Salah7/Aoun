class TopCharityModel {
  final String name;
  final double total;

  TopCharityModel({
    required this.name,
    required this.total,
  });

  factory TopCharityModel.fromJson(Map<String, dynamic> json) {
    return TopCharityModel(
      name: json['name'] ?? '',
      total: (json['total'] as num).toDouble(),
    );
  }
}