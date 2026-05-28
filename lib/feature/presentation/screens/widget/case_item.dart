import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes_manager/routes.dart';

class CaseItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double rateValue;
  final double collectedValue;
  final double allValue;
  final String status;

  const CaseItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.status,
  });

  bool get isFileImage => image.startsWith('/') || image.startsWith('file://');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.caseDetailsScreen,
          arguments: {
            "image": image,
            "title": title,
            "description": description,
            "rateValue": rateValue,
            "collectedValue": collectedValue,
            "allValue": allValue,
            "status": status,
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child:
                        isFileImage
                            ? Image.file(
                              File(image),
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.fill,
                            )
                            : Image.asset(
                              image,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                  ),

                  if (status == "عاجلة جداً" || status == "مكتملة")
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              status == "مكتملة"
                                  ? const Color(0xff287A54)
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              status == "مكتملة" ? "مكتملة" : "عاجلة",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xff757575),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: rateValue,
                    minHeight: 8,
                    backgroundColor: const Color(0xffD9D9D9),
                    color: const Color(0xff255A41),
                  ),
                ),
              ),

              status == "مكتملة"
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      "تم جمع 100%",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff757575),
                      ),
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Text(
                          "تم جمع $collectedValue ج.م",
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff255A41),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "من $allValue",
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff757575),
                          ),
                        ),
                      ],
                    ),
                  ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child:
                    status == "مكتملة"
                        ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                        : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2F674D),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.paymentScreen,
                              );
                            },
                            child: Text(
                              "تبرع الآن",
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
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
