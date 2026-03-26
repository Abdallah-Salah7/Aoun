import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_bottom_controls.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String titleText;
  final String paragraphText;
  final VoidCallback? skipFunction;

  const OnboardingContent({
    super.key,
    required this.titleText,
    required this.paragraphText,
    this.skipFunction,
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
                  style: TextStyle(
                    fontSize: isTablet ? 28 : size.width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                /// Paragraph
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        paragraphText,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 18 : size.width * 0.045,
                          color: PrimaryColors.secondaryColor,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                /// Bottom Controls
                BottomControls(skipFunction: skipFunction),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
