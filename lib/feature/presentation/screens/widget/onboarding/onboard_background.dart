import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final shortestSide = width < height ? width : height;
        final isTablet = width >= 600;

        return Container(
          color: const Color(0xFFD9DDDA),
          child: Stack(
            children: [
              /// Top Left Big Circle
              Positioned(
                top: height * 0.1,
                left: -shortestSide * 0.15,
                child: _circle(isTablet ? 180 : shortestSide * 0.3),
              ),

              /// Top Left Small Circle
              Positioned(
                top: height * 0.1,
                left: width * 0.15,
                child: _circle(isTablet ? 30 : shortestSide * 0.05),
              ),

              /// Bottom Right Big Circle
              Positioned(
                bottom: height * 0.35,
                right: -shortestSide * 0.15,
                child: _circle(isTablet ? 180 : shortestSide * 0.3),
              ),

              /// Bottom Right Small Circle
              Positioned(
                bottom: height * 0.45,
                right: width * 0.15,
                child: _circle(isTablet ? 30 : shortestSide * 0.05),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: PrimaryColors.primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
