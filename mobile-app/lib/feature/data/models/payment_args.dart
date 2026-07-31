class PaymentArgs {
  final bool isCase;
  final int targetId;
  final int amount;
  final String targetType;
  final String image;
  final String title;

  PaymentArgs({
    required this.isCase,
    required this.targetId,
    required this.amount,
    required this.targetType,
    required this.image,
    required this.title,
  });
}