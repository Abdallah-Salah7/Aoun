import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repositories/camp_repository.dart';
import 'camp_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final CampaignRepository repository;
  CampaignCubit(this.repository) : super(CampaignInitial());

  Future<void> fetchCampaigns(int charityId) async {
    emit(CampaignLoading());
    try {
      final result = await repository.getCampaigns(charityId);
      // الآن نرسل القائمة والإحصائيات معاً
      emit(CampaignLoaded(campaigns: result.campaigns, stats: result.stats));
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  void updateCampaign(int id, FormData formData) async {
    emit(CampaignLoading());
    try {
      await repository.updateCampaign(id, formData);
      emit(CampaignUpdatedSuccess());
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  void addCampaign(FormData formData) async {
    emit(CampaignLoading());
    try {
      await repository.addCampaign(formData);
      emit(CampaignAddedSuccess());
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  void deleteCampaign(int id) async {
    emit(CampaignLoading());
    try {
      await repository.deleteCampaign(id);
      emit(CampaignDeletedSuccess());
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }
}