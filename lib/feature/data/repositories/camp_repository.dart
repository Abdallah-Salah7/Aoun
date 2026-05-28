import 'package:dio/dio.dart';
import '../data_sources/camp_api_service.dart';
import '../models/camp_donation_model.dart';
import '../models/camp_model.dart';
import '../../domain/entities/camp_entity.dart';
import '../../domain/entities/campaigns_response_entity.dart';

class CampaignRepository {
  final CampApiService api;

  CampaignRepository(this.api);

  Future<CampaignsResponseEntity> getCampaigns(int charityId) async {
    final response = await api.getCampaignsByCharity(charityId);

    // في ملف Repository:
    final statsJson = response.data['stats'];
    final stats = statsJson != null
        ? StatsModel.fromJson(statsJson)
        : StatsModel(totalDonations: 0, campaignsCount: 0, donorsCount: 0);

    List<dynamic> list = response.data['campaigns'];
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
        lastDonations: model.lastDonations,
        weeklyDonations: model.weeklyDonations,
        monthlyDonations: model.monthlyDonations,
      );
    }).toList();

    return CampaignsResponseEntity(stats: stats, campaigns: campaigns);
  }

  Future<CampaignEntity> getDetails(int id) async {
    try {
      final response = await api.getCampaignDetails(id);
      final data = response.data; // هذا الـ JSON يحتوي على تفاصيل الحملة مباشرة

      return CampaignEntity(
        id: data['id'],
        title: data['title'] ?? "",
        imageUrl: data['imageUrl']?.toString().startsWith('http') == true
            ? data['imageUrl']
            : "https://aounplatform.runasp.net${data['imageUrl']}",
        description: data['description'] ?? "", // الآن سيقرأ الوصف بشكل صحيح
        requiredAmount: (data['requiredAmount'] as num?)?.toDouble() ?? 0.0,
        collectedAmount: (data['collectedAmount'] as num?)?.toDouble() ?? 0.0,
        donorsCount: data['donorsCount'] ?? 0,
        daysLeft: data['daysLeft'] ?? 0,
        isCompleted: data['completedAt'] != null,
        startDate: data['startDate'] != null ? DateTime.parse(data['startDate']) : DateTime.now(),
        endDate: data['endDate'] != null ? DateTime.parse(data['endDate']) : DateTime.now(),
        // جلب القوائم من التفاصيل
        lastDonations: data['lastDonations'] != null
            ? (data['lastDonations'] as List).map((e) => CampDonationModel.fromJson(e)).toList()
            : [],
      );
    } catch (e) {
      print("خطأ في جلب تفاصيل ID $id هو: $e");
      rethrow;
    }
  }

  Future<void> updateCampaign(int id, FormData formData) async => await api.updateCampaign(id, formData);
  Future<void> addCampaign(FormData formData) async => await api.addCampaign(formData);
  Future<void> deleteCampaign(int id) async => await api.deleteCampaign(id);
}