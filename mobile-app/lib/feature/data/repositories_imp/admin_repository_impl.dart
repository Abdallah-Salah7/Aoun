import '../../domain/repositories/admin_repository.dart';
import '../data_sources/admin_service.dart';
import '../models/admin_stats_model.dart';
import '../models/charity_model.dart';
import '../models/top_charity_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<AdminStatsModel> getAdminStats() {
    return remoteDataSource.getAdminStats();
  }
  @override
  Future<List<TopCharityModel>> getTopCharities() {
    return remoteDataSource.getTopCharities();
  }
  @override
  Future<List<CharityModel>> getPendingCharities() {
    return remoteDataSource.getPendingCharities();
  }
  @override
  Future<List<CharityModel>> getAcceptCharities() {
    return remoteDataSource.getAcceptCharities();
  }
  @override
  Future<List<CharityModel>> getRejectedCharities() {
    return remoteDataSource.getRejectedCharities();
  }
}