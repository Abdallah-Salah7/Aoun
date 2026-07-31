import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes_manager/routes.dart';

class CradlesItem extends StatelessWidget {
  final int campaignId; // 🔥 لازم عشان التفاصيل
  final String image;
  final String title;

  final String? description;
  final double? rateValue;
  final String? collectedValue;
  final String? allValue;
  final int? donorsCount;
  final int? daysLeft;

  const CradlesItem({
    super.key,
    required this.campaignId, // 🔥 مهم
    required this.image,
    required this.title,
    this.description,
    this.rateValue,
    this.collectedValue,
    this.allValue,
    this.donorsCount,
    this.daysLeft,
  });

  bool get isFile => image.startsWith('/') || image.startsWith('file://');

  @override
  Widget build(BuildContext context) {
    final progress = (rateValue ?? 0.0).clamp(0.0, 1.0);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.campaignDetails,
          arguments: campaignId, // 🔥 الصح
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: _buildImage(),
            ),
          ),

          /// TITLE CARD
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff323131),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 20,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        height: 252,
        width: 220,
        fit: BoxFit.cover,
      );
    }

    if (isFile) {
      return Image.file(
        File(image),
        height: 252,
        width: 220,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      image,
      height: 252,
      width: 220,
      fit: BoxFit.cover,
    );
  }
}