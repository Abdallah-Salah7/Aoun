import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_bottom_controls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingContent extends StatelessWidget {
  final String titleText;
  final String paragraphText;
  final VoidCallback? skipFunction;
  final VoidCallback? followFunction;

  const OnboardingContent({
    super.key,
    required this.titleText,
    required this.paragraphText,
    this.skipFunction, required this.followFunction,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 500 : double.infinity,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 40 : size.width * 0.06,
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.62),

                /// Title
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2B2D2C),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                /// Paragraph
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Text(
                        paragraphText,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inder(
                          fontSize: 25,
                          color: Color(0xff6A6969),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                /// Bottom Controls
                BottomControls(skipFunction: skipFunction, followFunction: followFunction,),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
