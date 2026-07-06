
import 'package:aoun/core/color_manager/app_color.dart';
import 'package:flutter/material.dart';

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;
  final bool multiLine;

  const InfoColumn({
    super.key,
    required this.title,
    required this.value,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.6,
            ),
            maxLines: multiLine ? null : 1,
            overflow: multiLine ? null : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}