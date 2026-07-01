import '../../data/models/admin_stats_model.dart';
import '../../data/models/charity_model.dart';
import '../../data/models/top_charity_model.dart';

abstract class AdminRepository {
  Future<AdminStatsModel> getAdminStats();
  Future<List<TopCharityModel>> getTopCharities();
  Future<List<CharityModel>> getPendingCharities();
  Future<List<CharityModel>> getAcceptCharities();
  Future<List<CharityModel>> getRejectedCharities();
}