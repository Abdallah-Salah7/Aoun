class FavoriteCase {
  final int id;
  final String title;
  final String description;

  FavoriteCase({
    required this.id,
    required this.title,
    required this.description,
  });

  factory FavoriteCase.fromJson(Map<String, dynamic> json) {
    return FavoriteCase(
      id: json["caseId"] ?? json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
    );
  }
}