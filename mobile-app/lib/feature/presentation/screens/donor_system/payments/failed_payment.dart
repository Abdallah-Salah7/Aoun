import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/payment_args.dart';

class FailedPaymentScreen extends StatelessWidget {
  final PaymentArgs args;
  const FailedPaymentScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/faild_process.png",
                  width: 127,
                  height: 127,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: size.height * 0.04),

              Text(
                "فشل في عملية الدفع",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "حدث خطأ، حاول مرة أخرى",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4C514F),
                ),
              ),

              SizedBox(height: size.height * 0.09),
              _buildButton(
                text: "إعادة المحاولة",
                isPrimary: true,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.creditDetailsScreen,
                    arguments: PaymentArgs(
                      isCase: false,
                      amount: 300,
                      targetId: 1,
                      targetType: "Campaign",
                        image: "assets/images/emergency_fund.png",
                      title: "فشل التبرع"
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              _buildButton(
                text: "العودة للرئيسية",
                isPrimary: false,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.paymentScreen,
                    arguments: args,
                  );
                },
              ),

              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 69,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isPrimary ? Colors.white : const Color(0xff356F52),
          foregroundColor: isPrimary ? const Color(0xffD41119) : Colors.white,
          side:
              isPrimary
                  ? const BorderSide(color: Color(0xffD41119), width: 1.3)
                  : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
