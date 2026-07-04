import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories_imp/donor_case_repository.dart';
import '../../../domain/entities/donor_case_entity.dart';
import 'donor_case_state.dart';

class DonorCaseCubit extends Cubit<DonorCaseState> {
  final DonorCaseRepository repository;

  DonorCaseCubit(this.repository) : super(DonorCaseInitial());

  final List<DonorCaseEntity> _cases = [];

  List<DonorCaseEntity> get cases => List.unmodifiable(_cases);

  Future<void> getCases({
    required String categoryName,
  }) async {
    emit(DonorCaseLoading());

    try {
      final result = await repository.getCases(
        categoryName: categoryName,
      );

      _cases
        ..clear()
        ..addAll(result);

      emit(DonorCaseLoaded(List.from(_cases)));
    } catch (e) {
      emit(DonorCaseError(e.toString()));
    }
  }

  /// تفاصيل حالة
  Future<void> getCaseDetails(int id) async {
    emit(DonorCaseLoading());

    try {
      final donorCase = await repository.getCaseDetails(id);

      emit(DonorCaseDetailsLoaded(donorCase));
    } catch (e) {
      emit(DonorCaseError(e.toString()));
    }
  }

  /// البحث
  List<DonorCaseEntity> search(String text) {
    if (text.trim().isEmpty) {
      return List.from(_cases);
    }

    return _cases.where((c) {
      return c.title.toLowerCase().contains(text.toLowerCase()) ||
          c.description.toLowerCase().contains(text.toLowerCase());
    }).toList();
  }

  /// الحالات العاجلة
  List<DonorCaseEntity> urgentCases() {
    return _cases.where((c) => c.isUrgent).toList();
  }
}