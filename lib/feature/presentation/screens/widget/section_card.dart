import 'package:aoun/core/color_manager/app_color.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final Widget child;

  const SectionCard({
    required this.title,
    required this.child,
    this.titleFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(height: 20, width: 4, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
