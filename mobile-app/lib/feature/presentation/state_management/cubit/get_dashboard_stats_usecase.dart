
import '../../../domain/entities/dashboard_entity.dart';
import '../../../domain/repositories/dashboard_repository.dart';

class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<DashboardEntity> call() async {
    return await repository.getDashboardStats();
  }
}