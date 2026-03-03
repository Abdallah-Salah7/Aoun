import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_background.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_content.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
              titleText: "فُرص تَبرع مُتنوعة",
              paragraphText:
                  "تُغطي جميع مجالات الخير وتصل إلى\n"
                  "من يستحقها من الفئات الأكثر\n"
                  "حاجة، لتمنحهم فرصة جديدة للحياة\n"
                  "وتمدّ لهم يد العون.",
              skipFunction: () {
                Navigator.pushReplacementNamed(context, Routes.onBoard3);
              },
            ),
          ),
        ],
      ),
    );
  }
}
