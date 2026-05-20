import 'package:aoun/feature/presentation/screens/donor_system/onboard_screens/onboard_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double offset = 120;
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        offset = 0;
        opacity = 1;
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff1A3D2D),

      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: opacity,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, offset, 0),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/splash.svg",
                  width: size.width * 0.22, // responsive
                ),

                Text(
                  "عَون",
                  style: TextStyle(
                    fontSize: size.width * 0.2, // responsive
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Text(
                  "عون … الخيرُ يبدأ بِك",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: size.width * 0.065,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
