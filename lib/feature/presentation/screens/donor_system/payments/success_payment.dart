import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';

class SuccessPaymentScreen extends StatelessWidget {
  final int amount;
  const SuccessPaymentScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/success.png",
                    width: 229,
                    height: 229,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Center(
                  child: Text(
                    " 🎉 تم التبرع بنجاح",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xff3E3E3E),
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  "! 💚شكرًا لك\n كل مساهمة مهما كانت بسيطة… تترك\n.أثرًا لا يُنسي",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4C514F),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "المبلغ المُتبرع به ",
                        style: TextStyle(
                          color: Color(0xff4C514F),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "$amount جنيه",
                          style: TextStyle(
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0E8B51),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.05),

                AuthButton(
                  text: "العودة للرئيسية",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.homePage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
