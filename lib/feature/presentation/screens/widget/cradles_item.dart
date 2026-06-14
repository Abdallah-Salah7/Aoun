import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes_manager/routes.dart';

class CradlesItem extends StatelessWidget {
  // الحقول المطلوبة فقط
  final String image;
  final String title;
  final String? description;
  final double? rateValue;
  final String? collectedValue;
  final String? allValue;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? donorsCount;
  final int? daysLeft;

  const CradlesItem({
    super.key,
    required this.image, // مطلوب
    required this.title, // مطلوب
    this.description,    // اختياري
    this.rateValue,
    this.collectedValue,
    this.allValue,
    this.status,
    this.startDate,
    this.endDate,
    this.donorsCount,
    this.daysLeft,
  });

  bool get isFileImage => image.startsWith('/') || image.startsWith('file://') || image.startsWith('http');

  @override
  Widget build(BuildContext context) {
    // حساب النسبة المئوية برمجياً (مع التعامل مع القيم الفارغة)
    final collected = double.tryParse(collectedValue ?? "0") ?? 0.0;
    final all = double.tryParse(allValue ?? "1") ?? 1.0;
    final calculatedRate = (all > 0) ? (collected / all) : 0.0;
    final finalRate = calculatedRate.clamp(0.0, 1.0);

    return InkWell(
      onTap: () {
        print("DESC = $description");
        Navigator.pushNamed(
          context,
          Routes.campaignDetails,
          arguments: {
            "image": image,
            "title": title,
            "description": description ?? "",
            "rateValue": finalRate,
            "collectedValue": collectedValue ?? "0",
            "allValue": allValue ?? "0",
            "status": status ?? "",
            "startDate": startDate,
            "endDate": endDate,
            "daysLeft": daysLeft,
            "donorsCount": donorsCount,
          },
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: image.startsWith('http')
                    ? Image.network(image, height: 252, width: 220, fit: BoxFit.cover)
                    : (isFileImage
                    ? Image.file(File(image), height: 252, width: 220, fit: BoxFit.cover)
                    : Image.asset(image, height: 252, width: 220, fit: BoxFit.cover)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff323131),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
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