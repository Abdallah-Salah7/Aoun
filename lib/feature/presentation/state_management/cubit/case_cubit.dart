import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/case_entity.dart';
import 'case_state.dart';

class CaseCubit extends Cubit<CaseState> {
  CaseCubit() : super(CaseInitial());

  List<CaseEntity> _cases = [];

  void loadInitialCases(List<CaseEntity> initial) {
    _cases = initial;
    emit(CaseLoaded(List.from(_cases)));
  }

  void addCase(CaseEntity newCase) {
    _cases.insert(0, newCase);
    emit(CaseLoaded(List.from(_cases)));
  }
  void updateCase(CaseEntity updatedCase) {
    final index = _cases.indexWhere((c) => c.id == updatedCase.id);

    if (index != -1) {
      _cases[index] = updatedCase;
      emit(CaseLoaded(List.from(_cases)));
    }
  }
  void deleteCase(String id) {
    _cases.removeWhere((c) => c.id == id);
    emit(CaseLoaded(List.from(_cases)));
  }
}
