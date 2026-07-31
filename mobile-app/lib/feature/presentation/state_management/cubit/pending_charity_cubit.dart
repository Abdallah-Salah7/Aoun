import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/admin_repository.dart';
import 'admin_state.dart';


class PendingCharitiesCubit
    extends Cubit<PendingCharitiesState> {

  final AdminRepository repository;

  PendingCharitiesCubit(this.repository)
      : super(PendingCharitiesInitial());

  Future<void> getPendingCharities() async {
    emit(PendingCharitiesLoading());

    try {
      final result =
      await repository.getPendingCharities();

      emit(PendingCharitiesSuccess(result));
    } catch (e) {
      emit(
        PendingCharitiesError(e.toString()),
      );
    }
  }
}