import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CaseItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  final String status;
  CaseItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
    required this.status,
  });

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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.asset(
                      image,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),

                  if (status == "عاجلة جداً")
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(45),
                        ),

                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "عاجلة",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (status == "مكتملة")
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff287A54),
                          borderRadius: BorderRadius.circular(45),
                        ),

                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "مكتملة",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color(0xff757575),
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
                    backgroundColor: Color(0xffD9D9D9),
                    color: Color(0xff255A41),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              status == "مكتملة"
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      "تم جمع 100%",
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757575),
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff255A41),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "من $allValue",
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575),
                          ),
                        ),
                      ],
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child:
                      status == "مكتملة"
                          ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xff8FAF9A),
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
                                SizedBox(width: 4),
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ],
                            ),
                          )
                          : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2F674D),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14),
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
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
