import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_background.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_content.dart';
import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

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
              titleText: "طُرق دفع آمنة وسهلة",
              paragraphText: "عَبر خياراتٍ متعددة تُسهل عملية التبرع والعطاء.",
              skipFunction: () {
                Navigator.pushNamed(context, Routes.userTypeScreen);
              }, followFunction: () {
              Navigator.pushNamed(context, Routes.onBoard4);
            },
            ),
          ),
        ],
      ),
    );
  }
}