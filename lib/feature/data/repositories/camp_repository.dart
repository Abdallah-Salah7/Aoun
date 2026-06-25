import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/camp_entity.dart';
import '../../domain/entities/campaigns_response_entity.dart';
import '../data_sources/camp_api_service.dart';
import '../models/camp_model.dart';
import '../models/growth_camp_model.dart';
import '../models/last_donation_model.dart';

class CampaignRepository {
  final CampApiService api;

  CampaignRepository(this.api);

  /// =========================
  /// GET CAMPAIGNS LIST
  /// =========================
  Future<CampaignsResponseEntity> getCampaigns(int charityId) async {
    final response = await api.getCampaignsByCharity(charityId);
    print("FULL RESPONSE = ${response.data}");

    final statsJson = response.data['stats'];
    final stats = statsJson != null
        ? StatsModel.fromJson(statsJson)
        : StatsModel(totalDonations: 0, campaignsCount: 0, donorsCount: 0);

    final List list = response.data['campaigns'] ?? [];

    final campaigns = list.map((e) {
      final model = CampaignModel.fromJson(e);

      return CampaignEntity(
        id: model.id,
        title: model.title ?? "",
        imageUrl: model.imageUrl ?? "",
        description: model.description ?? "",
        requiredAmount: model.requiredAmount,
        collectedAmount: model.collectedAmount,
        donorsCount: model.donorsCount,
        daysLeft: model.daysLeft,
        isCompleted: model.completedAt != null,
        startDate: model.startDate ?? DateTime.now(),
        endDate: model.endDate ?? DateTime.now(),
        weeklyCampDonations: const [],
        monthlyCampDonations: const [],
        lastCampDonations: const [],
      );
    }).toList();

    return CampaignsResponseEntity(
      stats: stats,
      campaigns: campaigns,
    );
  }

  /// =========================
  /// GET DETAILS
  /// =========================
  Future<CampaignEntity> getDetails(int id) async {
    final response = await api.getCampaignDetails(id);

    print("DETAIL API = ${response.data}");

    final model = CampaignModel.fromJson(response.data);

    print(model.weeklyDonations.first.toJson());
    return CampaignEntity(
      id: model.id,
      title: model.title ?? "",
      imageUrl: model.imageUrl ?? "",
      description: model.description ?? "",
      requiredAmount: model.requiredAmount,
      collectedAmount: model.collectedAmount,
      donorsCount: model.donorsCount,
      daysLeft: model.daysLeft,
      isCompleted: model.completedAt != null,
      startDate: model.startDate ?? DateTime.now(),
      endDate: model.endDate ?? DateTime.now(),
      weeklyCampDonations: model.weeklyDonations.map((e) {
        return GrowthCampModel(
          label: DateFormat('dd/MM').format(e.date),
          amount: e.amount,
        );
      }).toList(),
      monthlyCampDonations: model.monthlyDonations.map((e) {
        return GrowthCampModel(
          label: DateFormat('dd/MM').format(e.date),
          amount: e.amount,
        );
      }).toList(),

      lastCampDonations: model.lastDonations
          .map((e) => LastDonationModel.fromJson(e.toJson()))
          .toList(),
    );
  }

  Future<void> updateCampaign(int id, FormData formData) async {
    await api.updateCampaign(id, formData);
  }

  Future<void> addCampaign(FormData formData) async {
    await api.addCampaign(formData);
  }

  Future<void> deleteCampaign(int id) async {
    await api.deleteCampaign(id);
  }
}