import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/data/models/register_model.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/header_widget.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharityRegisterScreen extends StatelessWidget {
  CharityRegisterScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "البريد الإلكتروني مطلوب";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return "البريد الإلكتروني غير صحيح";
    }

    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return "كلمة المرور مطلوبة";
    }

    if (password.length < 8) {
      return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "يجب أن تحتوي على حرف كبير (A-Z)";
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "يجب أن تحتوي على حرف صغير (a-z)";
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "يجب أن تحتوي على رقم";
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]]').hasMatch(password)) {
      return "يجب أن تحتوي على رمز خاص";
    }

    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "تأكيد كلمة المرور مطلوب";
    }

    if (password != confirmPassword) {
      return "كلمتا المرور غير متطابقتين";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
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
                              label: "اسم الجمعية",
                              hint: "أدخل اسم الجمعية",
                              controller: nameController,
                            ),
                            SizedBox(height: height * 0.025),
                            CustomFormField(
                              label: "البريد الإلكترونى",
                              hint: "ex.email@gmail.com",
                              controller: emailController,
                            ),
                            SizedBox(height: height * 0.025),
                            CustomFormField(
                              label: "كلمة المرور",
                              hint: "أدخل كلمة المرور",
                              isPassword: true,
                              controller: passwordController,
                            ),
                            SizedBox(height: height * 0.025),
                            CustomFormField(
                              label: "تأكيد كلمة المرور",
                              hint: "أعد إدخال كلمة المرور",
                              isPassword: true,
                              controller: confirmPasswordController,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.04),

                      SizedBox(
                        width: double.infinity,
                        child: AuthButton(
                          text: "التالى",
                          onTap: () async {
                            if (nameController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("اسم الجمعية مطلوب"),
                                ),
                              );
                              return;
                            }

                            final emailError = validateEmail(
                              emailController.text,
                            );

                            if (emailError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(emailError)),
                              );
                              return;
                            }

                            final passwordError = validatePassword(
                              passwordController.text,
                            );

                            if (passwordError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(passwordError)),
                              );
                              return;
                            }

                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("كلمة المرور غير متطابقة"),
                                ),
                              );
                              return;
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("كلمة المرور غير متطابقة"),
                                ),
                              );
                              return;
                            }

                            try {
                              final model = RegisterModel(
                                fullName: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                accountType: "Charity",
                              );

                              final response = await ApiServices.register(
                                data: model.toJson(),
                              );

                              final prefs = await SharedPreferences.getInstance();

                              await prefs.setString(
                                "charityName",
                                nameController.text.trim(),
                              );

                              print(response.data);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("تم إنشاء الحساب بنجاح"),
                                ),
                              );

                              Navigator.pushNamed(
                                context,
                                Routes.loginToCompleteDataScreen,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
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
