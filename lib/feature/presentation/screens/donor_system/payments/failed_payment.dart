import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

class FailedPaymentScreen extends StatelessWidget {
  const FailedPaymentScreen({super.key});

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
              Container(
                width: size.width * 0.23,
                height: size.width * 0.23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xffBE1119), width: 4),
                ),
                child: const Center(
                  child: Icon(Icons.close, color: Color(0xffBE1119), size: 45),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              Text(
                "فشل في عملية الدفع",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.075,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "حدث خطأ، حاول مرة أخرى",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: PrimaryColors.secondaryColor,
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
                    arguments: 300,
                  ); // 300 will change
                },
              ),

              SizedBox(height: size.height * 0.02),

              _buildButton(
                text: "اختيار طريقة دفع أخرى",
                isPrimary: false,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.paymentScreen);
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
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.white : Colors.transparent,
          side: BorderSide(color: isPrimary ? Color(0xffBE1119) : Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Color(0xffBE1119) : Color(0xff272928),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
