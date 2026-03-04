import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const AuthButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScale = MediaQuery.textScaleFactorOf(context);
    final isTablet = size.width >= 600;

    return SizedBox(
      width: isTablet ? size.width * 0.5 : size.width * 0.8,
      height: min(size.height * 0.06, 60),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.035),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: (size.width * 0.055) * textScale,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
