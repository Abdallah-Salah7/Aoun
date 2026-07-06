import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/donor_system/payments/failed_payment.dart';
import 'package:aoun/feature/presentation/screens/donor_system/payments/processing_screen.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/payment_args.dart';

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
        MaterialPageRoute(
          builder: (_) => FailedPaymentScreen(
            args: PaymentArgs(
              isCase: widget.targetType == "Case",
              targetId: widget.targetId,
              amount: widget.amount,
              targetType: widget.targetType,
            ),
          ),
        ),
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
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: const Text(
              'الدفع بالبطاقة البنكية',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          foregroundColor: const Color(0xff255A41),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 8),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 33,
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// Amount
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  children: [
                     TextSpan(text: "مبلغ التبرع ",
                    style: GoogleFonts.sora(
                      fontSize: 32,fontWeight: FontWeight.w500
                    )
                    ),
                    TextSpan(
                      text: "${widget.amount}جنيه",
                      style: const TextStyle(color: Color(0xff137F4C),
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Card Number
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Text("رقم البطاقة",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),),
               ),
              const SizedBox(height: 12),
              TextField(
                controller: cardController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  "رقم البطاقة",
                  prefix: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/card.png",
                      width: 36,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("اسم حامل البطاقة",
                  style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: _inputDecoration("اسم حامل البطاقة"),
              ),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("تاريخ الانتهاء",
                  style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              const SizedBox(height: 12),

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

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(" رقم CVV*",
                  style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              const SizedBox(height: 12),
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

  InputDecoration _inputDecoration(
      String hint, {
        Widget? prefix,
      }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: prefix,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 60,
        minHeight: 40,
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xff6E6A6A),
          width: 1.3,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xff6E6A6A),
          width: 1.3,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
