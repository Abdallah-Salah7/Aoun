class DonorCaseEntity {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double requiredAmount;
  final double collectedAmount;
  final bool isUrgent;

  const DonorCaseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.isUrgent,
  });

  /// نحسب نسبة التبرعات
  double get progress {
    if (requiredAmount == 0) return 0;
    return collectedAmount / requiredAmount;
  }

  /// هل الحالة اكتملت؟
  bool get isCompleted {
    return collectedAmount >= requiredAmount;
  }
}