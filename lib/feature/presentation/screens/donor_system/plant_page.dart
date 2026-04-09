import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5EBE9),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: Text(
          "plant screen",
          style: GoogleFonts.manrope(
            fontSize: 22,
            fontWeight: FontWeight.w900, // SemiBold
            color: const Color(0xff252424),
          ),
        ),
      ),
    );
  }
}
