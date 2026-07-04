class DonorCaseDetailsModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final double progress;
  final bool isUrgent;
  final bool isCompleted;
  final String categoryName;
  final String charityName;
  final int donorsCount;

  DonorCaseDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.progress,
    required this.isUrgent,
    required this.isCompleted,
    required this.categoryName,
    required this.charityName,
    required this.donorsCount,
  });

  factory DonorCaseDetailsModel.fromJson(Map<String, dynamic> json) {
    return DonorCaseDetailsModel(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      requiredAmount: (json["requiredAmount"] ?? 0).toDouble(),
      collectedAmount: (json["collectedAmount"] ?? 0).toDouble(),
      progress: (json["progress"] ?? 0).toDouble(),
      isUrgent: json["isUrgent"] ?? false,
      isCompleted: json["isCompleted"] ?? false,
      categoryName: json["categoryName"] ?? "",
      charityName: json["charityName"] ?? "",
      donorsCount: json["donorsCount"] ?? 0,
    );
  }
}