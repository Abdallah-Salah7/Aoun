import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/header_widget.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/progress_bar.dart';
import 'package:flutter/material.dart';

class CharityRegisterScreen extends StatelessWidget {
  const CharityRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final cardWidth = width > 500 ? 420.0 : width * 0.9;

            double scaleFont(double size) => size * (width / 400);

            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: cardWidth,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04),

                      Header(
                        width: width,
                        title: 'إنشاء حساب الجمعية ',
                        subTitle:
                            'ابدأ بإنشاء حسابك للمتابعة واستكمال البيانات',
                      ),

                      SizedBox(height: height * 0.03),

                      ProgressBar(
                        active1: true,
                        active2: false,
                        active3: false,
                      ),

                      SizedBox(height: height * 0.04),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "إنشاء حساب",
                          style: TextStyle(
                            fontSize: scaleFont(30),
                            color: PrimaryColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      Container(
                        padding: EdgeInsets.all(width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CustomFormField(
                              label: "البريد الإلكترونى",
                              hint: "ex.email@gmail.com",
                            ),
                            SizedBox(height: height * 0.025),
                            CustomFormField(
                              label: "كلمة المرور",
                              hint: "أدخل كلمة المرور",
                              isPassword: true,
                            ),
                            SizedBox(height: height * 0.025),
                            CustomFormField(
                              label: "تأكيد كلمة المرور",
                              hint: "أعد إدخال كلمة المرور",
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.04),

                      SizedBox(
                        width: double.infinity,
                        child: AuthButton(
                          text: "التالى",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.charityDataScreen,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: height * 0.05),
                    ],
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
