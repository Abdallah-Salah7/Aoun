class ZakatModel {
  final double cash;
  final double bank;
  final double gold24;
  final double gold21;
  final double gold18;
  final double silverGrams;
  final double investments;
  final double debts;

  ZakatModel({
    required this.cash,
    required this.bank,
    required this.gold24,
    required this.gold21,
    required this.gold18,
    required this.silverGrams,
    required this.investments,
    required this.debts,
  });

  Map<String, dynamic> toJson() {
    return {
      "cash": cash,
      "bank": bank,
      "gold24": gold24,
      "gold21": gold21,
      "gold18": gold18,
      "silverGrams": silverGrams,
      "investments": investments,
      "debts": debts,
    };
  }
}