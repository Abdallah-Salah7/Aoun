
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
              color: Color(0xff134F33),
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xff1F2937),
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w600
            ),
            maxLines: multiLine ? null : 1,
            overflow: multiLine ? null : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}