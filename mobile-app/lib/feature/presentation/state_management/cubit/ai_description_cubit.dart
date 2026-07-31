import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/ai_description_request_model.dart';
import '../../../data/repositories_imp/ai_description_repository.dart';
import 'ai_description_state.dart';

class AiDescriptionCubit extends Cubit<AiDescriptionState> {
  final AiDescriptionRepository repository;

  AiDescriptionCubit(this.repository)
      : super(AiDescriptionInitial());

  Future<void> generateDescription({
    required String title,
    required String category,
    required double amount,
  }) async {
    emit(AiDescriptionLoading());

    try {
      final result = await repository.generateDescription(
        AiDescriptionRequest(
          title: title,
          category: category,
          amount: amount,
        ),
      );

      emit(AiDescriptionLoaded(result));
    } catch (e) {
      emit(AiDescriptionError(e.toString()));
    }
  }
}