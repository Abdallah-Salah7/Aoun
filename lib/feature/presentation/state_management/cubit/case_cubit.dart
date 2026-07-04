import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories_imp/case_repository.dart';
import '../../../domain/entities/case_entity.dart';
import 'case_state.dart';

class CaseCubit extends Cubit<CaseState> {
  final CaseRepository repository;

  CaseCubit(this.repository) : super(CaseInitial());

  final List<CaseEntity> _cases = [];

  Future<void> fetchCases() async {
    try {
      final cases = await repository.getCases();

      _cases.clear();
      _cases.addAll(cases);

      emit(CaseLoaded(List.from(_cases)));
    } catch (e) {
      print(e);
    }
  }

  void loadInitialCases(List<CaseEntity> initial) {
    _cases.clear();

    _cases.addAll(initial);

    emit(CaseLoaded(List.from(_cases)));
  }

  Future<void> addCase(FormData data) async {
    emit(CaseLoading());
    try {
      await repository.addCase(data);
      // لا نحتاج لإضافة أي شيء للقائمة يدوياً لأننا سنقوم بعمل refresh
      await fetchCases();
    } catch (e) {
      emit(CaseError(e.toString()));
    }
  }

  Future<void> updateCase(
      CaseEntity updatedCase, {
        File? imageFile,
      }) async {
    emit(CaseLoading());

    try {
      final result = await repository.updateCase(
        updatedCase,
        imageFile: imageFile,
      );

      final index = _cases.indexWhere((c) => c.id == result.id);

      if (index != -1) {
        _cases[index] = result;
      }

      emit(CaseLoaded(List.from(_cases)));
    } catch (e) {
      emit(CaseError(e.toString()));
    }
  }

// أضيفي Future قبل void
  Future<void> deleteCase(int id) async {
    emit(CaseLoading());
    try {
      // افترضي أن الحذف يأخذ وقتاً
      await repository.deleteCase(id);
      _cases.removeWhere((c) => c.id == id);
      emit(CaseLoaded(List.from(_cases)));
    } catch (e) {
      emit(CaseError(e.toString()));
    }
  }

  List<CaseEntity> getCasesByCategory(int categoryId) {
    return _cases.where((c) => c.categoryId == categoryId).toList();
  }

  /// ⬇️ الدالة الجديدة لجلب تفاصيل الحالة وتحديث عدد المتبرعين تلقائياً
  Future<void> refreshCaseDetails(int id) async {
    try {
      // جلب بيانات الحالة المفردة بالكامل من السيرفر
      final freshCase = await repository.getCaseById(id);

      // البحث عن مكان الحالة داخل القائمة المحلية
      final index = _cases.indexWhere((c) => c.id == id);

      if (index != -1) {
        // تحديث البيانات بالكامل (بما فيها عدد المتبرعين الصحيح)
        _cases[index] = freshCase;

        // إشعار الواجهات بالتحديث الجديد بدون عمل Loading للشاشة بالكامل
        emit(CaseLoaded(List.from(_cases)));
      }
    } catch (e) {
      print("Error refreshing case details in Cubit: $e");
    }
  }

}