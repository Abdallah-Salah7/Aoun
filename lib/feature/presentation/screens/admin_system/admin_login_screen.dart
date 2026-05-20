import 'package:aoun/feature/presentation/screens/widget/authentication/login/login_form.dart';

import 'package:aoun/feature/presentation/screens/widget/authentication/logo_widget.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                const LoginForm(isLogin: true, userType: 'admin'),
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
