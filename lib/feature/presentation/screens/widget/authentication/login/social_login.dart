import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final bool isLogin;
  const SocialLoginSection({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double fontSize = isTablet ? 16 : 13;
    final double iconSize = isTablet ? size.width * 0.12 : size.width * 0.14;
    final double spacing = size.width * 0.05;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            (isLogin) ? "طرق أخرى لتسجيل الدخول" : "طرق أخرى لإنشاء حساب",
            style: TextStyle(
              fontSize: fontSize,
              color: PrimaryColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton("assets/images/google.png", iconSize),
            SizedBox(width: spacing),
            _socialButton("assets/images/facebook.png", iconSize),
          ],
        ),
        SizedBox(height: size.height * 0.04),
        GestureDetector(
          onTap: () {
            (isLogin)
                ? Navigator.pushNamed(context, Routes.donorRegisteScreen)
                : Navigator.pop(context);
          },
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: isTablet ? 16 : 14,
                color: PrimaryColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(text: (isLogin) ? "ليس لديك حساب؟ " : " لديك حساب؟ "),
                TextSpan(
                  text: (isLogin) ? "إنشاء حساب" : "تسجيل الدخول",
                  style: TextStyle(
                    color: PrimaryColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(String imagePath, double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF2F2F2),
      ),
      child: Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
    );
  }
}
