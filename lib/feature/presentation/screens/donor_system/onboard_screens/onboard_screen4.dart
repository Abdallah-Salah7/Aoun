import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_background.dart';
import 'package:aoun/feature/presentation/screens/widget/onboarding/onboard_content.dart';
import 'package:flutter/material.dart';

import 'onboarding_video.dart';


class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

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
              image: const OnboardingVideo(
                videoPath: "assets/videos/onb4.mp4",
              ),
              titleText: "عطاؤك في أيدٍ أمينة",
              paragraphText: "جمعيات موثوقة تم التحقق منها،ليصل عطاؤك لمن يستحق بكل أمان وطمأنينة.", followFunction: () {
              Navigator.pushNamed(context, Routes.userTypeScreen);
            },
            ),
          ),
        ],
      ),
    );
  }
}