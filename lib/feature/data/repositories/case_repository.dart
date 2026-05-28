import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/entities/case_entity.dart';
import '../data_sources/case_api_service.dart';
import '../models/case_model.dart';

class CaseRepository {
  final CaseApiService api;

  CaseRepository(this.api);

  Future<List<CaseEntity>> getCases() async {
    final response = await api.getCases();

    print("GET CASES RESPONSE:");
    print(response.data);

    final data = response.data['data'];

    if (data == null || data is! List) {
      return [];
    }

    return data
        .map((e) => CaseModel.fromJson(e).toEntity())
        .toList();
  }

  Future<CaseEntity> updateCase(
      CaseEntity caseEntity, {
        File? imageFile,
      }) async {
    final formData = FormData.fromMap({
      "title": caseEntity.title,
      "description": caseEntity.description,
      "requiredAmount": caseEntity.requiredAmount,
      "categoryId": caseEntity.categoryId,
      "isUrgent": caseEntity.isUrgent,
      "status": caseEntity.status, // ✅ مهم جدًا

      if (imageFile != null)
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    print("FIELDS:");
    print(formData.fields);

    final response = await api.updateCase(
      caseEntity.id,
      formData,
    );

    print("RESPONSE:");
    print(response.data);

    return CaseModel.fromJson(
      response.data["data"],
    ).toEntity();
  }
  // ⬇️ أضيفي هذه الدالة داخل كلاس CaseRepository
  Future<CaseEntity> getCaseById(int id) async {
    final response = await api.getCaseById(id); // بتنادي دالة الـ Service اللي ضفناها سابقاً

    print("GET CASE DETAILS RESPONSE:");
    print(response.data);

    return CaseModel.fromJson(response.data['data']).toEntity();
  }
// في ملف CaseRepository
  Future<void> deleteCase(int id) async {
    await api.deleteCase(id); // الآن يجب أن تتعرف على الدالة
  }
  Future<void> addCase(FormData data) async {
    await api.addCase(data);
  }
}