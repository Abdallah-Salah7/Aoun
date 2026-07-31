class CampaignDetailsModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String charityName;
  final double requiredAmount;
  final double collectedAmount;
  final int donorsCount;
  final int daysLeft;

  CampaignDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.charityName,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.donorsCount,
    required this.daysLeft,
  });

  factory CampaignDetailsModel.fromJson(Map<String,dynamic> json){
    return CampaignDetailsModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      charityName: json["charityName"],
      requiredAmount: (json["requiredAmount"] as num).toDouble(),
      collectedAmount: (json["collectedAmount"] as num).toDouble(),
      donorsCount: json["donorsCount"],
      daysLeft: json["daysLeft"],
    );
  }
}