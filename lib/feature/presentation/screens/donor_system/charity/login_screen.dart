import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/login_form.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/logo_widget.dart';
import 'package:flutter/material.dart';

class CharityLoginScreen extends StatelessWidget {
  const CharityLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalSpacing = size.height * 0.03;
    final bool isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: verticalSpacing),
                const LogoWidget(),
                SizedBox(height: verticalSpacing),
                const LoginForm(isLogin: true, userType: 'charity',),
                SizedBox(height: verticalSpacing),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.charityRegisteScreen);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: PrimaryColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: "ليس لديك حساب؟ "),
                        TextSpan(
                          text: "إنشاء حساب",
                          style: TextStyle(
                            color: PrimaryColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
