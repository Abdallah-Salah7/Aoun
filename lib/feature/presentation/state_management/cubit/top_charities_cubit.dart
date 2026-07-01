import 'package:bloc/bloc.dart';

import '../../../data/models/top_charity_model.dart';
import '../../../domain/repositories/admin_repository.dart';
import 'admin_state.dart';
part 'top_charities_state.dart';

class TopCharitiesCubit
    extends Cubit<TopCharitiesState> {
  final AdminRepository repository;

  TopCharitiesCubit(this.repository)
      : super(TopCharitiesInitial());

  Future<void> getTopCharities() async {
    emit(TopCharitiesLoading());

    try {
      final result =
      await repository.getTopCharities();

      emit(TopCharitiesSuccess(result));
    } catch (e) {
      emit(
        TopCharitiesError(e.toString()),
      );
    }
  }


}
