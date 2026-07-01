import '../../../data/models/admin_stats_model.dart';
import '../../../data/models/charity_model.dart';

abstract class AdminStatsState {}

class AdminStatsInitial extends AdminStatsState {}

class AdminStatsLoading extends AdminStatsState {}

class AdminStatsSuccess extends AdminStatsState {
  final AdminStatsModel stats;

  AdminStatsSuccess(this.stats);
}

class AdminStatsError extends AdminStatsState {
  final String message;

  AdminStatsError(this.message);
}
abstract class PendingCharitiesState {}

class PendingCharitiesInitial
    extends PendingCharitiesState {}

class PendingCharitiesLoading
    extends PendingCharitiesState {}

class PendingCharitiesSuccess
    extends PendingCharitiesState {

  final List<CharityModel> charities;

  PendingCharitiesSuccess(this.charities);
}

class PendingCharitiesError
    extends PendingCharitiesState {

  final String message;

  PendingCharitiesError(this.message);
}