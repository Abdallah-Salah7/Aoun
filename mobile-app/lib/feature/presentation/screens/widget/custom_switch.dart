import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  static const _onTrackColor = Color(0xff559376);
  static const _offTrackColor = Color(0xff717573);
  static const _onThumbColor = Color(0xff2F674D);
  static const _offThumbColor = Color(0xffD9D9D9);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Scale relative to screen width, with sensible min/max bounds
    // so the switch never becomes too small or too large.
    final trackWidth = (width * 0.13).clamp(44.0, 56.0);
    final trackHeight = (width * 0.05).clamp(18.0, 24.0);
    final thumbSize = trackHeight - 4; // leaves 2px padding on each side

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: trackWidth,
        height: trackHeight,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(trackHeight),
          color: widget.value ? CustomSwitch._onTrackColor : CustomSwitch._offTrackColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: widget.value ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.value ? CustomSwitch._onThumbColor : CustomSwitch._offThumbColor,
            ),
          ),
        ),
      ),
    );
  }
}
