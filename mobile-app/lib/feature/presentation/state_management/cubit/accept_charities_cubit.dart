import 'package:bloc/bloc.dart';

import '../../../domain/repositories/admin_repository.dart';
import 'accept_charities_state.dart';

class AcceptCharitiesCubit
    extends Cubit<AcceptCharitiesState> {

  final AdminRepository repository;

  AcceptCharitiesCubit(this.repository)
      : super(AcceptCharitiesLoading());

  Future<void> getAcceptCharities() async {
    emit(AcceptCharitiesLoading());

    try {
      final charities =
      await repository.getAcceptCharities();

      emit(
        AcceptCharitiesSuccess(charities),
      );
    } catch (e) {
      emit(
        AcceptCharitiesError(e.toString()),
      );
    }
  }
}