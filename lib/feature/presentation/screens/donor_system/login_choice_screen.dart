import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/user_type_content.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoginChoiceScreen extends StatelessWidget {
  final String userType;
  const LoginChoiceScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE5EBE9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 1200) {
              cardWidth = 500; // Desktop / Web
            } else if (constraints.maxWidth > 900) {
              cardWidth = 450; // Web / Large Tablet
            } else if (constraints.maxWidth > 600) {
              cardWidth = 400; // Tablet
            } else {
              cardWidth = min(size.width * 0.9, 400); // Mobile
            }

            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: min(size.width * 0.05, 20),
                    ),
                    child: Content(
                      textButton1: "تسجيل الدخول",
                      textButton2: "إنشاء حساب ",
                      onTap1: () {
                        (userType == "donor")
                            ? Navigator.pushNamed(
                              context,
                              Routes.donorLoginScreen,
                            )
                            : (userType == "charity")
                            ? Navigator.pushNamed(
                              context,
                              Routes.charityLoginScreen,
                            )
                            : Navigator.pushNamed(
                              context,
                              Routes.adminLoginScreen,
                            );
                      },
                      onTap2: () {
                        (userType == "donor")
                            ? Navigator.pushNamed(
                              context,
                              Routes.donorRegisteScreen,
                            )
                            : (userType == "charity")
                            ? Navigator.pushNamed(
                              context,
                              Routes.charityRegisteScreen,
                            )
                            : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "يوجد حساب واحد فقط للأدمن لا يمكن انشاء اخر",
                                ),
                              ),
                            );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
