import 'package:bloc/bloc.dart';

import '../../../domain/repositories/admin_repository.dart';
import 'admin_state.dart';

class AdminStatsCubit extends Cubit<AdminStatsState> {
  final AdminRepository repository;

  AdminStatsCubit(this.repository)
      : super(AdminStatsInitial());

  Future<void> getStats() async {
    emit(AdminStatsLoading());

    try {
      final stats = await repository.getAdminStats();

      emit(AdminStatsSuccess(stats));
    } catch (e) {
      emit(AdminStatsError(e.toString()));
    }
  }
}