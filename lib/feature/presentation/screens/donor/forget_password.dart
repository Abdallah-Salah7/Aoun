import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            "assets/images/flowbite_clock-arrow-outline.png",
                            height: constraints.maxWidth * 0.3,
                            width: constraints.maxWidth * 0.3,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: constraints.maxHeight * 0.03),

                        Text(
                          "نسيت كلمة المرور",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.045,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "من فضلك أدخل البريد الإلكترونى الخاص بك\n لإعادة تعيين كلمة المرور",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: PrimaryColors.secondaryColor,
                            height: 1.5,
                            fontSize: constraints.maxWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 30),

                        const CustomFormField(
                          label: 'البريد الإلكترونى',
                          hint: 'ex.email@gmail.com',
                          labelFontWeight: FontWeight.w700,
                        ),

                        const SizedBox(height: 30),

                        AuthButton(text: "إرسال رمز", onTap: () {}),
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
