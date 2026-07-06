class CharityDetailsModel {
  final int id;
  final String charityName;
  final String licenseNumber;
  final String status;
  final String description;
  final String createdAt;
  final List<DocumentModel> documents;

  CharityDetailsModel({
    required this.id,
    required this.charityName,
    required this.licenseNumber,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.documents,
  });

  factory CharityDetailsModel.fromJson(Map<String, dynamic> json) {
    return CharityDetailsModel(
      id: json['id'],
      charityName: json['charityName'],
      licenseNumber: json['licenseNumber'],
      status: json['status'],
      description: json['description'],
      createdAt: json['createdAt'],
      documents: (json['documents'] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList(),
    );
  }
}

class DocumentModel {
  final String documentType;
  final String filePath;

  DocumentModel({
    required this.documentType,
    required this.filePath,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      documentType: json['documentType'],
      filePath: json['filePath'],
    );
  }
}