class DonorCampaignModel {
  final int id;
  final String title;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final int daysRemaining;

  DonorCampaignModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.daysRemaining,
  });

  factory DonorCampaignModel.fromJson(Map<String,dynamic> json){
    return DonorCampaignModel(
      id: json["id"],
      title: json["title"],
      imageUrl: json["imageUrl"],
      requiredAmount: (json["requiredAmount"] as num).toDouble(),
      collectedAmount: (json["collectedAmount"] as num).toDouble(),
      daysRemaining: json["daysRemaining"],
    );
  }
}