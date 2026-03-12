import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

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
                      label: "كلمة المرور الجديدة",
                      hint: "أدخل كلمة المرور",
                      isPassword: true,
                    ),

                    SizedBox(height: height * 0.02),

                    CustomFormField(
                      label: "تأكيد كلمة المرور",
                      hint: "أعد إدخال كلمة المرور",
                      isPassword: true,
                    ),

                    SizedBox(height: height * 0.12),

                    Center(
                      child: AuthButton(
                        text: "تغيير كلمة المرور",
                        onTap: () {},
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
