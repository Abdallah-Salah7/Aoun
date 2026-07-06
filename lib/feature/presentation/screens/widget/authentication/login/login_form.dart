import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../main.dart';
import '../../../../../data/data_sources/admin_service.dart';
import '../../../../../data/data_sources/api_services.dart';
import '../../../../../data/models/register_model.dart';
import '../../../../../domain/repositories/admin_repository.dart';
import '../../../../state_management/cubit/admin_cubit.dart';
import '../../../../state_management/cubit/camp_cubit.dart';
import '../../../../state_management/cubit/case_cubit.dart';
import '../../../admin_system/admin_home.dart';

class LoginForm extends StatefulWidget {
  final bool isLogin;
  final bool istempLogin;
  final String userType;

  const LoginForm({
    super.key,
    required this.isLogin,
    required this.istempLogin,
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
                      Navigator.pushNamed(context, Routes.forgetPasswordScreen);
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

              SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "تذكرنى عند الدخول مرة أخرى",
                      style: TextStyle(
                        color: Color(0xff757575),
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  Transform.scale(
                    scale: isLargeScreen ? 1.5 : 1.4,
                    child: Checkbox(
                      value: remember,
                      activeColor: PrimaryColors.primaryColor,
                      side: BorderSide(color: PrimaryColors.secondaryColor),
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
                    text: (widget.isLogin) ? "تسجيل الدخول" : "إنشاء حساب",

                    onTap: () async {
                      // ================= REGISTER =================
                      final emailError = validateEmail(emailController.text);

                      if (emailError != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(emailError)));
                        return;
                      }

                      final passwordError = validatePassword(
                        passwordController.text,
                      );

                      if (passwordError != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(passwordError)));
                        return;
                      }

                      if (!widget.isLogin) {
                        final confirmError = validateConfirmPassword(
                          passwordController.text,
                          confirmPasswordController.text,
                        );

                        if (confirmError != null) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(confirmError)));
                          return;
                        }
                      }
                      if (!widget.isLogin && widget.userType == "donor") {
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

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
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
                            final prefs = await SharedPreferences.getInstance();

                            // ===== ADMIN =====
                            if (data["role"] == "Admin") {
                              await prefs.setString(
                                "adminToken",
                                data["token"],
                              );

                              await ApiServices.setToken(data["token"]);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"])),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => AdminStatsCubit(
                                      getIt<AdminRepository>(),
                                    )..getStats(),
                                    child: const AdminHome(),
                                  ),
                                ),
                              );
                            }
                            // ===== CHARITY =====
                            else if (data["role"] == "Charity") {
                              await prefs.setString(
                                "charityToken",
                                data["token"],
                              );

                              await ApiServices.setToken(data["token"]);

                              // جلب بيانات الجمعية الحالية
                              final charityResponse =
                                  await ApiServices.getCharityStatus();

                              await prefs.setInt(
                                "charityId",
                                charityResponse.data["data"]["id"],
                              );

                              await prefs.setString(
                                "charityName",
                                charityResponse.data["data"]["charityName"],
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"])),
                              );
                              final charityId =
                                  charityResponse.data["data"]["id"];

                              await context.read<CaseCubit>().fetchCases();

                              await context
                                  .read<CampaignCubit>()
                                  .fetchCampaigns(charityId);
                              try {
                                final statusResponse =
                                    await ApiServices.getCharityStatus();

                                final status =
                                    statusResponse.data["data"]["status"];

                                // Pending = الحساب قيد المراجعة
                                // Rejected = تم رفض الطلب
                                // Approved = تم قبول الطلب

                                if (status == "Approved") {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.homeCharity,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.accountStateScreen,
                                  );
                                }
                              } on DioException catch (e) {
                                if (e.response?.statusCode == 404) {
                                  //  لم يتم إنشاء ملف الجمعية بعد
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.charityDataScreen,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "حدث خطأ: ${e.response?.data["message"] ?? e.message}",
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                            // ===== DONOR =====
                            else {
                              final token = data["token"];

                              await prefs.setString("donorToken", token);

                              await prefs.setString(
                                "userRole",
                                data["role"] ?? "",
                              );

                              await ApiServices.setToken(token);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"])),
                              );

                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homePage,
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  data["message"] ?? "فشل تسجيل الدخول",
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
