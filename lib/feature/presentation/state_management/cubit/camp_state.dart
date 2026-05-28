import '../../../data/models/camp_model.dart';
import '../../../domain/entities/camp_entity.dart';

abstract class CampaignState {}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;
  final StatsModel stats;

  CampaignLoaded({required this.campaigns, required this.stats});
}

// حالات النجاح للعمليات المختلفة
class CampaignUpdatedSuccess extends CampaignState {}
class CampaignAddedSuccess extends CampaignState {}
class CampaignDeletedSuccess extends CampaignState {}

class CampaignError extends CampaignState {
  final String message;
  CampaignError(this.message);
}