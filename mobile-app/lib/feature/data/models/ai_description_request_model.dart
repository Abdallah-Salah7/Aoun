class AiDescriptionRequest {
  final String title;
  final String category;
  final double amount;

  AiDescriptionRequest({
    required this.title,
    required this.category,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "amount": amount,
    };
  }
}