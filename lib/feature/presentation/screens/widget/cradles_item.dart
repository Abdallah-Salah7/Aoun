import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes_manager/routes.dart';

class CradlesItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  final String status;
  final DateTime startDate;
  final DateTime endDate;

  const CradlesItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  bool get isFileImage => image.startsWith('/') || image.startsWith('file://');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.campaignDetails,
          arguments: {
            "image": image,
            "title": title,
            "description": description,
            "rateValue": rateValue,
            "collectedValue": collectedValue,
            "allValue": allValue,
            "status": status,
            "startDate": startDate,
            "endDate": endDate,
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
                child:
                    isFileImage
                        ? Image.file(
                          File(image),
                          height: 252,
                          width: 220,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
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
                title,
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
