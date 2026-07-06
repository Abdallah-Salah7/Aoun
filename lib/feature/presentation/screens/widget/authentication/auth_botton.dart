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
      width: 335,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
