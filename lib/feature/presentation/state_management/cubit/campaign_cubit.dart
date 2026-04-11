import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/campaign_entity.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit() : super(CampaignInitial());

  final List<CampaignEntity> _campaigns = [];

  void loadInitialCases(List<CampaignEntity> initial) {
    _campaigns.clear();
    _campaigns.addAll(initial);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  void addCase(CampaignEntity newCase) {
    _campaigns.insert(0, newCase);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  void updateCase(CampaignEntity updatedCase) {
    final index = _campaigns.indexWhere((c) => c.id == updatedCase.id);

    if (index != -1) {
      _campaigns[index] = updatedCase;
      emit(CampaignLoaded(List.from(_campaigns)));
    }
  }

  void deleteCase(String id) {
    _campaigns.removeWhere((c) => c.id == id);
    emit(CampaignLoaded(List.from(_campaigns)));
  }

  List<CampaignEntity> getCasesByCategory(String category) {
    return _campaigns.where((c) => c.category == category).toList();
  }
}