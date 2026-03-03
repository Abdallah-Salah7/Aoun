import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double avatarRadius = size.width * 0.28;
    final double logoSize = avatarRadius * 0.9;
    final double textSize = size.width * 0.14;

    return CircleAvatar(
      radius: avatarRadius.clamp(80, 140),
      backgroundColor: PrimaryColors.primaryColor.withOpacity(0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/logo.png",
              width: logoSize.clamp(60, 110),
              height: logoSize.clamp(60, 110),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: size.height * 0.004),
          Text(
            "عَون",
            style: TextStyle(
              fontSize: textSize.clamp(28, 52),
              fontWeight: FontWeight.w900,
              color: PrimaryColors.primaryColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
