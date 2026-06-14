import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CampaignDetails extends StatefulWidget {
  final Map<String, dynamic> args;
  const CampaignDetails({super.key, required this.args});

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final image = widget.args["image"];
    final title = widget.args["title"];
    final rateValue = widget.args["rateValue"];
    final collectedValue = widget.args["collectedValue"];
    final allValue = widget.args["allValue"];
    final description = widget.args["description"] ?? "";
    final donorsCount = widget.args["donorsCount"];
    final daysLeft = widget.args["daysLeft"];

    return Scaffold(
      backgroundColor: Color(0xffE5EBE9),
      appBar: AppBar(toolbarHeight: 15),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Stack(
                    children: [
                      buildImage(image),

                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff387056),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            margin: EdgeInsets.all(8),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          Spacer(),

                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff387056),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            margin: EdgeInsets.all(8),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSaved = !isSaved;
                                });
                              },
                              icon: Icon(
                                isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 8,
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
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
                                  "$daysLeft يوم متبقى",
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage(ImageAssets.vector),
                                  ),
                                ),
                                Text(
                                  " $donorsCountمتبرع",
                                  style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تفاصيل الحملة",
                          style: GoogleFonts.manrope(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                    Text(
                      description.isEmpty ? "لا يوجد وصف متاح" : description,
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575),
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.charityProfileScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              "مقدمة من ",
                              style: GoogleFonts.manrope(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff757575),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: Image(
                                  image: AssetImage(ImageAssets.ghaith),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "غيث للتنمية المجتمعية",
                                style: GoogleFonts.manrope(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff757575),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
        ],
      ),
    );
  }

  int getRemainingDays() {
    final endDate = widget.args["endDate"] as DateTime?;
    if (endDate == null) return 0;

    final now = DateTime.now();
    return endDate.difference(now).inDays.clamp(0, 9999);
  }

  Widget buildImage(String image) {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        width: double.infinity,
        height: 292,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 292,
          color: Colors.grey,
          child: const Icon(Icons.broken_image),
        ),
      );
    }

    if (image.startsWith('/') || image.startsWith('file://')) {
      return Image.file(
        File(image),
        width: double.infinity,
        height: 292,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      image,
      width: double.infinity,
      height: 292,
      fit: BoxFit.cover,
    );
  }
}
