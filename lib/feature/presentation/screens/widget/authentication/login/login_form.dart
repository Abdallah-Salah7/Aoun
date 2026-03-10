import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final bool isLogin;
  const LoginForm({super.key, required this.isLogin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool remember = false;

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
                  ? const CustomFormField(
                    label: "اسم المستخدم",
                    hint: "أعد إدخال اسم المستخدم",
                  )
                  : SizedBox(),
              const CustomFormField(
                label: "البريد الإلكترونى",
                hint: "ex.email@gmail.com",
              ),
              SizedBox(height: spacing),
              const CustomFormField(
                label: "كلمة المرور",
                hint: "أدخل كلمة المرور",
                isPassword: true,
              ),
              (!widget.isLogin)
                  ? const CustomFormField(
                    label: "تأكيد كلمة المرور",
                    hint: "أعد إدخال كلمة المرور",
                    isPassword: true,
                  )
                  : SizedBox(),
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
                  : SizedBox(),
              SizedBox(height: spacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "باستمرارك، فإنك توافق على شروط الاستخدام\n وسياسة الخصوصية الخاصة بنا.",
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
                      side: BorderSide(color: PrimaryColors.secondaryColor),
                      onChanged: (v) => setState(() => remember = v!),
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
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.homePage);
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
