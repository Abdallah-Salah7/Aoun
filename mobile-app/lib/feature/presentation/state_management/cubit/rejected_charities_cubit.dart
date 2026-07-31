import 'package:aoun/feature/presentation/state_management/cubit/rejected_charities_state.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/repositories/admin_repository.dart';

class RejectedCharitiesCubit extends Cubit<RejectedCharitiesState> {
  final AdminRepository repository;

  RejectedCharitiesCubit(this.repository)
      : super(RejectedCharitiesInitial());

  Future<void> getRejectedCharities() async {
    emit(RejectedCharitiesLoading());

    try {
      final charities = await repository.getRejectedCharities();

      emit(RejectedCharitiesSuccess(charities));
    } catch (e) {
      emit(RejectedCharitiesError(e.toString()));
    }
  }
}