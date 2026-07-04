import '../../domain/entities/donor_case_entity.dart';
import '../data_sources/donor_case_api_service.dart';
import '../models/donor_case_model.dart';

class DonorCaseRepository {
  final DonorCaseApiService api;

  DonorCaseRepository(this.api);

  Future<List<DonorCaseEntity>> getCases({
    required String categoryName,
  }) async {
    final response = await api.getCases(
      categoryName: categoryName,
    );

    final List data = response.data["data"];

    return data
        .map(
          (e) => DonorCaseModel.fromJson(
        Map<String, dynamic>.from(e),
      ).toEntity(),
    )
        .toList();
  }

  Future<DonorCaseEntity> getCaseDetails(int id) async {
    final response = await api.getCaseDetails(id);

    return DonorCaseModel.fromJson(
      Map<String, dynamic>.from(response.data),
    ).toEntity();
  }
}