import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CradlesItem extends StatelessWidget {
  final String image;
  final String name;
  CradlesItem({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.campaignDetails,
          arguments: {
            "image": image,
            "title": name,
            "rateValue": 0.6,
            "collectedValue": "٨٩٠٠",
            "allValue": "١٨,٠٠٠",
          },
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  height: 252,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff323131),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 40),
              child: Text(
                name,
                style: GoogleFonts.abrilFatface(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
