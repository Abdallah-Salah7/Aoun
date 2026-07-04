class RecommendCaseEntity {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final bool isUrgent;

  const RecommendCaseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.isUrgent,
  });

  double get progress {
    if (requiredAmount == 0) return 0;
    return collectedAmount / requiredAmount;
  }

  bool get isReallyCompleted {
    return collectedAmount >= requiredAmount;
  }
}