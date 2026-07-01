class CharityModel {
  final int id;
  final String charityName;
  final String licenseNumber;
  final String status;
  final String description;
  final String createdAt;

  CharityModel({
    required this.id,
    required this.charityName,
    required this.licenseNumber,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) {
    return CharityModel(
      id: json['id'],
      charityName: json['charityName'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}