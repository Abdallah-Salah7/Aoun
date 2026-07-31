import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/entities/case_entity.dart';
import '../data_sources/case_api_service.dart';
import '../models/case_model.dart';

class CaseRepository {
  final CaseApiService api;

  CaseRepository(this.api);

  Future<List<CaseEntity>> getCases() async {
    final activeResponse = await api.getCases(status: "all");
    final completedResponse = await api.getCases(status: "completed");

    final activeData = activeResponse.data['cases'] as List? ?? [];
    final completedData = completedResponse.data['cases'] as List? ?? [];

    final activeCases = activeData
        .map((e) => CaseModel.fromJson(e).toEntity())
        .toList();

    final completedCases = completedData
        .map((e) => CaseModel.fromJson(e).toEntity())
        .toList();

    // منع التكرار لو الـ API رجع حالات مكتملة ضمن all مستقبلاً
    final Map<int, CaseEntity> uniqueCases = {};

    for (final c in [...activeCases, ...completedCases]) {
      uniqueCases[c.id] = c;
    }

    return uniqueCases.values.toList();
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
    print("CASE DETAILS: ${response.data}");
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