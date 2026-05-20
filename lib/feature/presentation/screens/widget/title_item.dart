import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleItem extends StatelessWidget {
  final Color color;
  final String name;
  const TitleItem({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: GoogleFonts.radley(
        fontSize: 19,
        fontWeight: FontWeight.w600, 
        color: color,
      ),
    );
  }
}
