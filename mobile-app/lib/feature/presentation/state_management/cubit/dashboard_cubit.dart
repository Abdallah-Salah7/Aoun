
import 'package:bloc/bloc.dart';

import 'dashboard_state.dart';
import 'get_dashboard_stats_usecase.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardCubit(this.getDashboardStatsUseCase)
      : super(DashboardInitial());

  Future<void> getDashboardStats() async {
    emit(DashboardLoading());

    try {
      final result = await getDashboardStatsUseCase();
      emit(DashboardSuccess(result));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}