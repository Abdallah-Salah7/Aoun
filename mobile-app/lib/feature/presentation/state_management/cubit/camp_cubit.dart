import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repositories_imp/camp_repository.dart';
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
    print("DELETE ID = $id");

    emit(CampaignLoading());

    try {
      await repository.deleteCampaign(id);

      print("DELETE SUCCESS");

      emit(CampaignDeletedSuccess());

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
      print("DELETE ERROR = $e");

      String message = "حدث خطأ أثناء الحذف";

      if (e is DioException) {
        print("STATUS = ${e.response?.statusCode}");
        print("BODY = ${e.response?.data}");

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