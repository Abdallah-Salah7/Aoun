import '../../../domain/entities/campaign_entity.dart';

abstract class CampaignState {}

class CampaignInitial extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;

  CampaignLoaded(this.campaigns);
}
