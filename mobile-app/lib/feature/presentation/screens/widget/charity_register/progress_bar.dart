import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final bool active1;
  final bool active2;
  final bool active3;
  const ProgressBar({
    required this.active1,
    required this.active2,
    required this.active3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final barHeight = screenHeight * 0.008;
    final spacing = screenWidth * 0.015;

    return Row(
      children: [
        Expanded(child: _progressItem(active3, barHeight)),
        SizedBox(width: spacing),
        Expanded(child: _progressItem(active2, barHeight)),
        SizedBox(width: spacing),
        Expanded(child: _progressItem(active1, barHeight)),
      ],
    );
  }

  Widget _progressItem(bool active, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: active ? PrimaryColors.primaryColor : Colors.blueGrey[300],
        borderRadius: BorderRadius.circular(
          height * 2,
        ), // radius relative to height
      ),
    );
  }
}
