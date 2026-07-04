import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/donor_system/payments/failed_payment.dart';
import 'package:aoun/feature/presentation/screens/donor_system/payments/processing_screen.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';

class CreditDetails extends StatefulWidget {
  final int amount;
  final int targetId;
  final String targetType;

  const CreditDetails({
    super.key,
    required this.amount,
    required this.targetId,
    required this.targetType,
  });

  @override
  State<CreditDetails> createState() => _CreditDetailsState();
}

class _CreditDetailsState extends State<CreditDetails> {
  final cardController = TextEditingController();
  final nameController = TextEditingController();
  final mmController = TextEditingController();
  final yyController = TextEditingController();
  final cvvController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    cardController.dispose();
    nameController.dispose();
    mmController.dispose();
    yyController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    if (isLoading) return;

    /// 1- CARD NUMBER VALIDATION
    if (cardController.text.trim().isEmpty) {
      _showMsg("من فضلك أدخل رقم البطاقة");
      return;
    }

    if (cardController.text.trim().length < 12) {
      _showMsg("رقم البطاقة غير صحيح");
      return;
    }

    /// 2- NAME VALIDATION
    if (nameController.text.trim().isEmpty) {
      _showMsg("من فضلك أدخل اسم حامل البطاقة");
      return;
    }

    /// 3- EXPIRY VALIDATION
    if (mmController.text.trim().isEmpty || yyController.text.trim().isEmpty) {
      _showMsg("من فضلك أدخل تاريخ الانتهاء");
      return;
    }

    int? month = int.tryParse(mmController.text.trim());
    int? year = int.tryParse(yyController.text.trim());

    if (month == null || month < 1 || month > 12) {
      _showMsg("شهر الانتهاء غير صحيح");
      return;
    }

    if (year == null || year < 25) {
      _showMsg("سنة الانتهاء غير صحيحة");
      return;
    }

    /// 4- CVV VALIDATION
    if (cvvController.text.trim().isEmpty) {
      _showMsg("من فضلك أدخل CVV");
      return;
    }

    if (cvvController.text.trim().length < 3) {
      _showMsg("CVV غير صحيح");
      return;
    }

    setState(() => isLoading = true);

    /// 5- Processing Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProcessingScreen(amount: widget.amount),
      ),
    );

    try {
      /// 6- Create Donation
      final createRes = await ApiServices.createDonation(
        donorName: nameController.text,
        amount: widget.amount.toDouble(),
        targetId: widget.targetId,
        targetType: widget.targetType,
      );

      final donationId = createRes.data["donationId"];

      /// 7- Pay Donation
      await ApiServices.payDonation(
        donationId: donationId,
        cardNumber: cardController.text.trim(),
        expiryDate: "${mmController.text}/${yyController.text}",
        cvv: cvvController.text.trim(),
        cardHolderName: nameController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        Routes.successPaymentScreen,
        arguments: widget.amount,
      );
    } catch (e) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FailedPaymentScreen()),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: const Text(
            'الدفع بالبطاقة البنكية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          foregroundColor: const Color(0xff255A41),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// Amount
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  children: [
                    const TextSpan(text: "مبلغ التبرع "),
                    TextSpan(
                      text: "${widget.amount}",
                      style: const TextStyle(color: Color(0xff2E7D32)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Card Number
              const Text("رقم البطاقة"),
              TextField(
                controller: cardController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("رقم البطاقة"),
              ),

              const SizedBox(height: 20),

              /// Name
              const Text("اسم حامل البطاقة"),
              TextField(
                controller: nameController,
                decoration: _inputDecoration("اسم حامل البطاقة"),
              ),

              const SizedBox(height: 20),

              /// Expiry
              const Text("تاريخ الانتهاء"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: mmController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("MM"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: yyController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("YY"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// CVV
              const Text("CVV"),
              SizedBox(
                width: width * 0.4,
                child: TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration("CVV"),
                ),
              ),

              const SizedBox(height: 40),

              /// Button
              Center(
                child: AuthButton(
                  text: isLoading ? "جاري الدفع..." : "تأكيد الدفع",
                  onTap: _pay,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xff6E6A6A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xff255A41), width: 1.5),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    );
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
