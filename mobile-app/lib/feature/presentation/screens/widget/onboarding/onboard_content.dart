import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_bottom_controls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingContent extends StatelessWidget {
  final String titleText;
  final String paragraphText;
  final VoidCallback? skipFunction;
  final VoidCallback? followFunction;
  final Widget image;

  const OnboardingContent({
    super.key,
    required this.titleText,
    required this.paragraphText,
    this.skipFunction,
    required this.followFunction,
    required this.image,
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
              horizontal: isTablet ? 40 : 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                        
                  SizedBox(
                   width: 280,
                    height: 480,
                    child: Center(
                      child: image,
                    ),
                  ),
                        
                  const SizedBox(height: 25),
                        
                  Text(
                    titleText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff2B2D2C),
                    ),
                  ),
                        
                  const SizedBox(height: 18),
                        
                  Text(
                    paragraphText,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inder(
                      fontSize: 23,
                      color: const Color(0xff6A6969),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                        
                  BottomControls(
                    skipFunction: skipFunction,
                    followFunction: followFunction,
                  ),
                        
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}