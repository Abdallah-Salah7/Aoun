import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/data_sources/api_services.dart';
import '../../../../../data/models/register_model.dart';

class LoginForm extends StatefulWidget {
  final bool isLogin;
  final String userType;

  const LoginForm({
    super.key,
    required this.isLogin,
    required this.userType,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool remember = false;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLargeScreen = size.width > 600;
    final double containerWidth = isLargeScreen ? 400 : size.width * 0.9;
    final double fontSize = isLargeScreen ? 16 : 14;
    final double spacing = isLargeScreen ? 25 : 15;

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: containerWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (!widget.isLogin)
                  ? CustomFormField(
                controller: nameController,
                label: "اسم المستخدم",
                hint: "اسم المستخدم",
              )
                  : const SizedBox(),

              CustomFormField(
                controller: emailController,
                label: "البريد الإلكترونى",
                hint: "ex.email@gmail.com",
              ),

              SizedBox(height: spacing),

              CustomFormField(
                controller: passwordController,
                label: "كلمة المرور",
                hint: "أدخل كلمة المرور",
                isPassword: true,
              ),

              (!widget.isLogin)
                  ? CustomFormField(
                controller: confirmPasswordController,
                label: "تأكيد كلمة المرور",
                hint: "أعد إدخال كلمة المرور",
                isPassword: true,
              )
                  : const SizedBox(),

              SizedBox(height: spacing * 0.6),

              (widget.isLogin)
                  ? InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.forgetPasswordScreen,
                  );
                },
                child: Text(
                  "هل نسيت كلمة المرور؟",
                  style: TextStyle(
                    color: PrimaryColors.primaryColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
                  : const SizedBox(),

              SizedBox(height: spacing),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "باستمرارك، فإنك توافق على شروط الاستخدام وسياسة الخصوصية الخاصة بنا.",
                      style: TextStyle(
                        color: PrimaryColors.secondaryColor,
                        fontSize: fontSize,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  Transform.scale(
                    scale: isLargeScreen ? 1.5 : 1.3,
                    child: Checkbox(
                      value: remember,
                      activeColor: PrimaryColors.primaryColor,
                      side: BorderSide(
                        color: PrimaryColors.secondaryColor,
                      ),
                      onChanged: (v) {
                        setState(() {
                          remember = v!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spacing * 0.6),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: AuthButton(
                    text: (widget.isLogin)
                        ? "تسجيل الدخول"
                        : "إنشاء حساب",

                    onTap: () async {

                      // ================= REGISTER =================

                      if (!widget.isLogin &&
                          widget.userType == "donor") {

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

                            confirmPassword:
                            confirmPasswordController.text,

                            accountType: "Donor",
                          );
                          final response = await ApiServices.register(
                            data: model.toJson(),
                          );

                          final prefs = await SharedPreferences.getInstance();

                          await prefs.setString(
                            "userName",
                            nameController.text,
                          );

                          print(response.data);

                          print(response.data);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم إنشاء الحساب بنجاح"),
                            ),
                          );

                          Navigator.pushReplacementNamed(
                            context,
                            Routes.donorLoginScreen,
                          );

                        } catch (e) {

                          print(e);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      }

                      // ================= LOGIN =================

                      else if (widget.isLogin) {

                        try {

                          final response = await ApiServices.login(
                            data: {
                              "email": emailController.text,
                              "password": passwordController.text,
                            },
                          );

                          final data = response.data;
                          print("LOGIN RESPONSE = $data");
                          if (data["isSuccess"] == true) {

                            final prefs =
                            await SharedPreferences.getInstance();

                            // ===== ADMIN =====

                            if (data["role"] == "Admin") {

                              await prefs.setString(
                                "adminToken",
                                data["token"],
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(data["message"]),
                                ),
                              );

                              Navigator.pushReplacementNamed(
                                context,
                                Routes.adminHome,
                              );
                            }

                            // ===== DONOR =====

                            else {

                              final token = data["token"];

                              await prefs.setString(
                                "donorToken",
                                token,
                              );

                              await prefs.setString(
                                "userRole",
                                data["role"] ?? "",
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(data["message"]),
                                ),
                              );

                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homePage,
                              );
                              print("LOGIN RESPONSE = $data");
                            }                          }

                          else {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(data["message"]),
                              ),
                            );
                          }

                        } catch (e) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error: $e"),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}