import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repositories/camp_repository.dart';
import 'camp_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final CampaignRepository repository;

  CampaignCubit(this.repository) : super(CampaignInitial());

  int? _charityId;

  /// =========================
  /// FETCH CAMPAIGNS
  /// =========================
  Future<void> fetchCampaigns(int charityId) async {
    _charityId = charityId;

    emit(CampaignLoading());

    try {
      final result = await repository.getCampaigns(charityId);

      emit(
        CampaignLoaded(
          campaigns: result.campaigns,
          stats: result.stats,
        ),
      );
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  /// =========================
  /// UPDATE CAMPAIGN
  /// =========================
  Future<void> updateCampaign(
      int id,
      FormData formData,
      ) async {
    emit(CampaignLoading());

    try {
      await repository.updateCampaign(id, formData);

      emit(CampaignUpdatedSuccess());

      if (_charityId != null) {
        final result = await repository.getCampaigns(_charityId!);

        emit(
          CampaignLoaded(
            campaigns: result.campaigns,
            stats: result.stats,
          ),
        );
      }
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  /// =========================
  /// ADD CAMPAIGN
  /// =========================
  Future<void> addCampaign(FormData formData) async {
    emit(CampaignLoading());

    try {
      await repository.addCampaign(formData);

      if (_charityId == null) {
      }

      final result = await repository.getCampaigns(_charityId!);

      emit(CampaignLoaded(
        campaigns: result.campaigns,
        stats: result.stats,
      ));
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }

  /// =========================
  /// DELETE CAMPAIGN
  /// =========================
  Future<void> deleteCampaign(int id) async {
    emit(CampaignLoading());

    try {
      await repository.deleteCampaign(id);

      emit(CampaignDeletedSuccess());

      if (_charityId != null) {
        final result = await repository.getCampaigns(_charityId!);

        emit(CampaignLoaded(
          campaigns: result.campaigns,
          stats: result.stats,
        ));
      }
    } catch (e) {
      String message = "حدث خطأ أثناء الحذف";

      if (e is DioException) {
        final data = e.response?.data;
        if (data != null && data["message"] != null) {
          message = data["message"];
        }
      }

      emit(CampaignError(message));
    }
  }


  void clearError() {
    if (state is CampaignError && _charityId != null) {
      fetchCampaigns(_charityId!);
    }
  }
}