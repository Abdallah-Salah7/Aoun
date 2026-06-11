import 'package:dio/dio.dart';

import '../data_sources/camp_api_service.dart';
import '../models/camp_model.dart';
import '../models/growth_camp_model.dart';
import '../models/last_donation_model.dart';

import '../../domain/entities/camp_entity.dart';
import '../../domain/entities/campaigns_response_entity.dart';

class CampaignRepository {
  final CampApiService api;

  CampaignRepository(this.api);

  /// =========================
  /// GET CAMPAIGNS LIST
  /// =========================
  Future<CampaignsResponseEntity> getCampaigns(int charityId) async {
    final response = await api.getCampaignsByCharity(charityId);

    final statsJson = response.data['stats'];
    final stats = statsJson != null
        ? StatsModel.fromJson(statsJson)
        : StatsModel(totalDonations: 0, campaignsCount: 0, donorsCount: 0);

    final List<dynamic> list = response.data['campaigns'];

    final campaigns = list.map((e) {
      final model = CampaignModel.fromJson(e);

      return CampaignEntity(
        id: model.id,
        title: model.title,
        imageUrl: model.imageUrl,
        description: model.description ?? "",
        requiredAmount: model.requiredAmount,
        collectedAmount: model.collectedAmount,
        donorsCount: model.donorsCount,
        daysLeft: model.daysLeft,
        isCompleted: model.completedAt != null,
        startDate: model.startDate ?? DateTime.now(),
        endDate: model.endDate ?? DateTime.now(),

        // list endpoint doesn't provide chart details usually
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
  /// GET CAMPAIGN DETAILS
  /// =========================
  Future<CampaignEntity> getDetails(int id) async {
    try {
      final response = await api.getCampaignDetails(id);
      final data = response.data;

      return CampaignEntity(
        id: data['id'],
        title: data['title'] ?? "",
        imageUrl: data['imageUrl']?.toString().startsWith('http') == true
            ? data['imageUrl']
            : "https://aounplatform.runasp.net${data['imageUrl']}",

        description: data['description'] ?? "",

        requiredAmount: (data['requiredAmount'] as num?)?.toDouble() ?? 0.0,
        collectedAmount: (data['collectedAmount'] as num?)?.toDouble() ?? 0.0,
        donorsCount: data['donorsCount'] ?? 0,
        daysLeft: data['daysLeft'] ?? 0,

        isCompleted: data['endDate'] != null &&
            DateTime.parse(data['endDate']).isBefore(DateTime.now()),

        startDate: data['startDate'] != null
            ? DateTime.parse(data['startDate'])
            : DateTime.now(),

        endDate: data['endDate'] != null
            ? DateTime.parse(data['endDate'])
            : DateTime.now(),

        /// =========================
        /// CHART DATA (FIXED)
        /// =========================
        weeklyCampDonations: (data['weeklyDonations'] as List?)
            ?.map((e) => GrowthCampModel.fromJson(e))
            .toList() ??
            [],

        monthlyCampDonations: (data['monthlyDonations'] as List?)
            ?.map((e) => GrowthCampModel.fromJson(e))
            .toList() ??
            [],

        lastCampDonations: (data['lastDonations'] as List?)
            ?.map((e) => LastDonationModel.fromJson(e))
            .toList() ??
            [],
      );
    } catch (e) {
      print("❌ Error getting campaign details: $e");
      rethrow;
    }
  }

  /// =========================
  /// UPDATE
  /// =========================
  Future<void> updateCampaign(int id, FormData formData) async {
    await api.updateCampaign(id, formData);
  }

  /// =========================
  /// ADD
  /// =========================
  Future<void> addCampaign(FormData formData) async {
    await api.addCampaign(formData);
  }

  /// =========================
  /// DELETE
  /// =========================
  Future<void> deleteCampaign(int id) async {
    await api.deleteCampaign(id);
  }
}