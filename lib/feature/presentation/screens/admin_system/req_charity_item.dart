import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';

class ReqCharityItem extends StatelessWidget {
  final String charityName;
  final String applicationDate;
  final VoidCallback onDetailsPressed;
  final int charityId;

  const ReqCharityItem({
    super.key,
    required this.charityName,
    required this.applicationDate,
    required this.onDetailsPressed,
    required this.charityId,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    charityName,
                    style: GoogleFonts.manrope(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(ImageAssets.iconDate),
                      height: 28,
                      width: 28,
                      color: Color(0xff3F7C5E),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      "تاريخ التقديم",
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),

                    const SizedBox(width: 15),

                    Text(
                      applicationDate,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.reqCharityReview,
                      arguments: charityId,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1F6A43),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "عرض التفاصيل",
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.visibility_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}