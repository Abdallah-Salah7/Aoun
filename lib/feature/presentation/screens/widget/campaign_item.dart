import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CampaignItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  final DateTime? startDate;
  final DateTime? endDate;
  final int daysLeft;
  final int donorsCount;

  const CampaignItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.startDate,
    required this.endDate,
    required this.daysLeft,
    required this.donorsCount,
  });

  // إضافة دعم للروابط الشبكية (http) بجانب الملفات المحلية
  bool get isFileImage => image.startsWith('/') || image.startsWith('file://');
  bool get isNetworkImage => image.startsWith('http');

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
            "startDate": startDate,
            "endDate": endDate,
            "daysLeft": daysLeft,
            "donorsCount": donorsCount,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم الصورة
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: isNetworkImage
                    ? Image.network(image, width: double.infinity, height: 180, fit: BoxFit.cover)
                    : (isFileImage
                    ? Image.file(File(image), width: double.infinity, height: 180, fit: BoxFit.cover)
                    : Image.asset(image, width: double.infinity, height: 180, fit: BoxFit.cover)),
              ),

              // قسم العنوان والأيام المتبقية
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.saira(fontWeight: FontWeight.bold, fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(ImageAssets.iconDate, height: 34, width: 34),
                        ),
                        Text(
                          "${daysLeft} يوم متبقى",
                          style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // شريط التقدم (يستخدم الـ rateValue الجاهز من الموديل)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: rateValue.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: const Color(0xffD9D9D9),
                    color: const Color(0xff255A41),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // قيم التبرعات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      "تم جمع $collectedValue ج.م",
                      style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xff255A41)),
                    ),
                    const Spacer(),
                    Text(
                      "من $allValue",
                      style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xff757575)),
                    ),
                  ],
                ),
              ),

              // زر التبرع
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F674D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, Routes.paymentScreen),
                    child: Text("تبرع الآن", style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  int getRemainingDays() {
    final date = endDate;
    if (date == null) return 0;

    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    return difference < 0 ? 0 : difference;
  }
}