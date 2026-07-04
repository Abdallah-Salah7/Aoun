import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  String? validateInputs() {
    if (currentPasswordController.text.trim().isEmpty) {
      return "أدخل كلمة المرور الحالية";
    }

    if (newPasswordController.text.trim().isEmpty) {
      return "أدخل كلمة المرور الجديدة";
    }

    if (newPasswordController.text.length < 8) {
      return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    }

    if (!RegExp(r'[A-Z]').hasMatch(newPasswordController.text)) {
      return "يجب أن تحتوي كلمة المرور على حرف كبير";
    }

    if (!RegExp(r'[a-z]').hasMatch(newPasswordController.text)) {
      return "يجب أن تحتوي كلمة المرور على حرف صغير";
    }

    if (!RegExp(r'[0-9]').hasMatch(newPasswordController.text)) {
      return "يجب أن تحتوي كلمة المرور على رقم";
    }

    if (!RegExp(
      r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]]',
    ).hasMatch(newPasswordController.text)) {
      return "يجب أن تحتوي كلمة المرور على رمز خاص";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9DDDA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: width * 0.06,
                          backgroundColor: const Color(0xff91AEA1),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: width * 0.05,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Text(
                          "تغيير كلمة المرور",
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                            color: PrimaryColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                      ],
                    ),

                    SizedBox(height: height * 0.12),

                    CustomFormField(
                      label: "كلمة المرور الحالية",
                      hint: "أدخل كلمة المرور الحالية",
                      isPassword: true,
                      controller: currentPasswordController,
                    ),

                    SizedBox(height: height * 0.02),

                    CustomFormField(
                      label: "كلمة المرور الجديدة",
                      hint: "أدخل كلمة المرور الجديدة",
                      isPassword: true,
                      controller: newPasswordController,
                    ),

                    SizedBox(height: height * 0.12),

                    Center(
                      child: AuthButton(
                        text: "تغيير كلمة المرور",
                        onTap: () async {
                          final error = validateInputs();

                          if (error != null) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                            return;
                          }

                          try {
                            final response = await ApiServices.changePassword(
                              currentPassword:
                                  currentPasswordController.text.trim(),
                              newPassword: newPasswordController.text.trim(),
                            );

                            if (response.statusCode == 200) {
                              if (response.data == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("تم تغيير كلمة المرور بنجاح"),
                                  ),
                                );

                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "كلمة المرور الحالية غير صحيحة",
                                    ),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("حدث خطأ، حاول مرة أخرى"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
