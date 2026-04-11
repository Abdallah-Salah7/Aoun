
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/campaign_entity.dart';

class CharityCampaignItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  final String status;
  final String category;

  const CharityCampaignItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.status,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.charityCampaignDetails,
          arguments: CampaignEntity(
            id: "",
            title: title,
            description: description,
            image: image,
            category: category,
            status: status,
            rateValue: rateValue,
            collectedValue: collectedValue,
            allValue: allValue,
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: (image.startsWith('/') || image.contains('file://'))
                      ? Image.file(
                    File(image),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    image.isNotEmpty ? image : ImageAssets.upload,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              ],
            ),

            /// TITLE
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Image(
                        image: AssetImage(ImageAssets.iconDate),
                        height: 34,
                        width: 34,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "30 يوم متبقى",
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 25),
                  child: Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),

            /// PROGRESS
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: rateValue,
                  minHeight: 6,
                  backgroundColor: const Color(0xffE0E0E0),
                  color: const Color(0xff2F674D),
                ),
              ),
            ),

            /// VALUES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تم جمع $collectedValue ج.م",
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff255A41),
                        ),
                      ),
                      Text(
                        "من $allValue",
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff757575),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Image(image: AssetImage(ImageAssets.vector)),
                      const SizedBox(height: 5),
                      Text(
                        "125 متبرع",
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// BUTTON
            status == "مكتملة"
                ? Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff8FAF9A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "اكتملت",
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12),
                    side: const BorderSide(
                        color: Color(0xff737373), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.editCase,
                      arguments: CampaignEntity(
                        id: "",
                        title: title,
                        description: description,
                        image: image,
                        category: category,
                        status: status,
                        rateValue: rateValue,
                        collectedValue: collectedValue,
                        allValue: allValue,
                      ),
                    );
                  },
                  icon: Text(
                    "تعديل الحالة",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff737373),
                    ),
                  ),
                  label: const Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Color(0xff737373),
                    size: 30,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
