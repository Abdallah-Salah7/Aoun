import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/otp_boxes.dart';
import 'package:flutter/material.dart';

class EmailVerfication extends StatelessWidget {
  final String email;
  const EmailVerfication({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    return Scaffold(
      backgroundColor: const Color(0xFFD9DDDA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width:
                        constraints.maxWidth > 500
                            ? 400
                            : constraints.maxWidth * 0.9,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: constraints.maxWidth * 0.06,
                              backgroundColor: const Color(0xff91AEA1),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: constraints.maxHeight * 0.05),

                        Center(
                          child: Image.asset(
                            "assets/images/email_verify.png",
                            height: constraints.maxWidth * 0.3,
                            width: constraints.maxWidth * 0.3,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: constraints.maxHeight * 0.03),

                        Text(
                          "تحقق من بريدك الإلكترونى",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.045,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "لقد أرسلنا رابط إعادة تعيين كلمة المرور إلى $email ، أدخل رمز التحقق المكوّن من 5 أرقام الذي تم إرساله إليك.",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: PrimaryColors.secondaryColor,
                            height: 1.5,
                            fontSize: constraints.maxWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 30),
                        OtpBoxes(),
                        const SizedBox(height: 30),
                        AuthButton(
                          text: "تحقق",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.changePasswordScreen,
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 18,
                                color: PrimaryColors.secondaryColor,
                              ),
                              children: [
                                TextSpan(text: "لم تتلقَّ رمز التحقق بعد؟."),
                                TextSpan(
                                  text: "إعادة الإرسال.",
                                  style: TextStyle(
                                    color: PrimaryColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
