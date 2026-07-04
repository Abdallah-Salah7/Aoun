class PaymentArgs {
  final bool isCase;
  final int targetId;
  final int amount;
  final String targetType;

  PaymentArgs({
    required this.isCase,
    required this.targetId,
    required this.amount,
    required this.targetType,
  });
}