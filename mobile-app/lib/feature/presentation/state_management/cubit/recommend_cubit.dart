import 'package:bloc/bloc.dart';

import '../../../domain/repositories/recommend_repository.dart';
import 'recommend_state.dart';

class RecommendCubit extends Cubit<RecommendState> {
  final RecommendRepository repository;

  RecommendCubit(this.repository) : super(RecommendInitial());

  Future<void> fetchRecommendCases(String userId) async {
    emit(RecommendLoading());

    try {
      final result = await repository.getRecommendCases(userId);

      emit(
        RecommendLoaded(
          recommendCases: result,
        ),
      );
    } catch (e) {
      emit(
        RecommendError(
          e.toString(),
        ),
      );
    }
  }
}