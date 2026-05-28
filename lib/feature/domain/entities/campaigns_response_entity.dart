import '../../domain/entities/camp_entity.dart';
import '../../data/models/camp_model.dart'; // ليتمكن من رؤية StatsModel

class CampaignsResponseEntity {
  final StatsModel stats;
  final List<CampaignEntity> campaigns;

  CampaignsResponseEntity({required this.stats, required this.campaigns});
}