class AiResponseModel {
  final String answer;

  AiResponseModel({
    required this.answer,
  });

  factory AiResponseModel.fromJson(Map<String, dynamic> json) {
    return AiResponseModel(
      answer: json["answer"] ?? "",
    );
  }
}