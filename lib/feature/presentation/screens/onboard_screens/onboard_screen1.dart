import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_background.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_content.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          const Positioned.fill(child: BackgroundDecoration()),

          /// Content
          Positioned.fill(
            child: OnboardingContent(
              titleText: "عَطاؤك....يُغير مصيراً",
              paragraphText:
                  "خُطوة مِنك تُنقذ حَياة وتفتح باب أمل ،\nلتترك أثراً لا يُينسى.",
              skipFunction: () {
                Navigator.pushReplacementNamed(context, Routes.onBoard2);
              },
            ),
          ),
        ],
      ),
    );
  }
}
