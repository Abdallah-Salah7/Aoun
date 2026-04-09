import 'package:aoun/feature/presentation/screens/widget/authentication/login/login_form.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/social_login.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/logo_widget.dart';
import 'package:flutter/material.dart';

class DonorRegisterScreen extends StatelessWidget {
  const DonorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalSpacing = size.height * 0.03;

    return Scaffold(
      backgroundColor: const Color(0xFFD9DDDA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: verticalSpacing),
                const LogoWidget(),
                SizedBox(height: verticalSpacing),
                const LoginForm(isLogin: false),
                SizedBox(height: verticalSpacing),
                const SocialLoginSection(isLogin: false),
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
