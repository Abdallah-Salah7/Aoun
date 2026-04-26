import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

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
                Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff0E8B51), width: 4),
                  ),
                  child: Icon(
                    Icons.check,
                    size: size.width * 0.15,
                    color: Color(0xff0E8B51),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Text(
                  "تم التبرع بنجاح",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "شكراً لمساهمتك فى مساعدة الحالة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.043,
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
                        "المبلغ المتبرع به",
                        style: TextStyle(
                          color: Color(0xff4C514F),
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "100 جنيه",
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
