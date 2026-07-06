import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends StatelessWidget {
  final String textButton1;
  final String textButton2;
  final String? textButton3;
  final void Function() onTap1;
  final void Function() onTap2;
  final void Function()? onTap3;
  const Content({
    super.key,
    required this.textButton1,
    required this.textButton2,
    required this.onTap1,
    required this.onTap2,
    this.textButton3,
    this.onTap3,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? size.width * 0.2 : size.width * 0.08,
          ),
          child: Column(
            children: [
              // SizedBox(height: size.height * 0.06),

              LogoWidget(),
              SizedBox(height: size.height * 0.03),

              Text(
                "عون … الخير يبدأ بك",
                textAlign: TextAlign.center,
                style: GoogleFonts.inder(
                  color: Color(0xff6A6969),
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: size.height * 0.05),

              Text(
                "اختر طريقتك للدخول",
                style: GoogleFonts.inder(
                fontWeight: FontWeight.w600,
                  fontSize: 32
                ),
              ),

              SizedBox(height: size.height * 0.03),

              AuthButton(text: textButton1, onTap: onTap1),
              SizedBox(height: size.height * 0.02),
              AuthButton(text: textButton2, onTap: onTap2),

              SizedBox(height: size.height * 0.02),
              (textButton3 == null && onTap3 == null)
                  ? SizedBox()
                  : AuthButton(text: textButton3!, onTap: onTap3!),
            ],
          ),
        ),
      ),
    );
  }
}
