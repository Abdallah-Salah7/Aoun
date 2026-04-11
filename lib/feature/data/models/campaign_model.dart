

import '../../domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.category,
    required super.status,
    required super.rateValue,
    required super.collectedValue,
    required super.allValue,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      category: json['category'],
      status: json['status'],
      rateValue: json['rateValue'],
      collectedValue: json['collectedValue'],
      allValue: json['allValue'],
    );
  }
}