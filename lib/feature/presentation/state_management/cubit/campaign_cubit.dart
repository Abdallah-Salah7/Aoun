import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/campaign_entity.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit() : super(CampaignInitial());

  final List<CampaignEntity> _campaigns = [];

  void loadInitialCampaigns(List<CampaignEntity> initial) {
    _campaigns.clear();
    _campaigns.addAll(initial);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  void addCampaign(CampaignEntity newCampaign) {
    _campaigns.insert(0, newCampaign);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  void updateCampaign(CampaignEntity updated) {
    final index = _campaigns.indexWhere((c) => c.id == updated.id);

    if (index != -1) {
      _campaigns[index] = updated;
      emit(CampaignLoaded(List.from(_campaigns)));
    }
  }

  void deleteCampaign(String id) {
    _campaigns.removeWhere((c) => c.id == id);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  List<CampaignEntity> getCampaignsByCategory(String category) {
    return _campaigns.where((c) => c.category == category).toList();
  }
}
