import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final double width;
  final String title;
  final String subTitle;

  const Header({
    super.key,
    required this.width,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: width * 0.07,
            fontWeight: FontWeight.w600,
            color: PrimaryColors.primaryColor,
          ),
        ),
        SizedBox(height: width * 0.02),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.05,
            color: PrimaryColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
