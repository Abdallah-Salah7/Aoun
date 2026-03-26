import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CampaignItem extends StatelessWidget {
  final String image;
  final String title;
  final double rateValue;
  final String collectedValue;
  final String allValue;
  CampaignItem({
    super.key,
    required this.image,
    required this.title,
    required this.rateValue,
    required this.collectedValue,
    required this.allValue,
  });

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
            "rateValue": rateValue,
            "collectedValue": collectedValue,
            "allValue": allValue,
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
                      height: 220,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.saira(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
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
                  ],
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
              Padding(
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
                  child: SizedBox(
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
                        Navigator.pushNamed(context, Routes.paymentScreen);
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
