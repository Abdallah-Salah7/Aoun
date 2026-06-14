import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/data_sources/camp_api_service.dart';

class CampaignDetails extends StatefulWidget {
  final int campaignId;

  const CampaignDetails({
    super.key,
    required this.campaignId,
  });

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  bool isSaved = false;

  late Future campaignFuture;

  @override
  void initState() {
    super.initState();
    campaignFuture = CampApiService().getCampaignDetails(
      widget.campaignId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: FutureBuilder(
        future: campaignFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "حدث خطأ أثناء تحميل البيانات",
                style: GoogleFonts.cairo(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.data == null) {
            return const Center(
              child: Text("لا توجد بيانات"),
            );
          }

          final data = snapshot.data!.data;

          final String title = data["title"] ?? "";
          final String image = data["imageUrl"] ?? "";
          final String description =
              data["description"] ?? "";

          final int donorsCount =
              data["donorsCount"] ?? 0;

          final int daysLeft =
              data["daysLeft"] ?? 0;

          final num collected =
              data["collectedAmount"] ?? 0;

          final num required =
              data["requiredAmount"] ?? 1;

          final double rateValue =
          (collected / required)
              .clamp(0.0, 1.0)
              .toDouble();

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      /// IMAGE
                      Stack(
                        children: [
                          buildImage(image),

                          Row(
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                  const Color(0xff387056),
                                  borderRadius:
                                  BorderRadius.circular(
                                    45,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              Container(
                                margin:
                                const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                  const Color(0xff387056),
                                  borderRadius:
                                  BorderRadius.circular(
                                    45,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSaved = !isSaved;
                                    });
                                  },
                                  icon: Icon(
                                    isSaved
                                        ? Icons.bookmark
                                        : Icons
                                        .bookmark_border,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// TITLE
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        child: Align(
                          alignment:
                          Alignment.centerRight,
                          child: Text(
                            title,
                            style:
                            GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// INFO CARD
                      Container(
                        margin:
                        const EdgeInsets.all(18),
                        padding:
                        const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  ImageAssets.iconDate,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "$daysLeft يوم متبقي",
                                  style:
                                  GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                10,
                              ),
                              child:
                              LinearProgressIndicator(
                                value: rateValue,
                                minHeight: 8,
                                backgroundColor:
                                const Color(
                                  0xffD9D9D9,
                                ),
                                color:
                                const Color(
                                  0xff255A41,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              children: [
                                Text(
                                  "تم جمع $collected ج.م",
                                  style:
                                  GoogleFonts.manrope(
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    const Color(
                                      0xff255A41,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "من $required",
                                  style:
                                  GoogleFonts.manrope(
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Image.asset(
                                  ImageAssets.vector,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "$donorsCount متبرع",
                                  style:
                                  GoogleFonts.manrope(
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// DESCRIPTION
                      Container(
                        margin:
                        const EdgeInsets.all(18),
                        padding:
                        const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "تفاصيل الحملة",
                              style:
                              GoogleFonts.manrope(
                                fontSize: 22,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              description.isEmpty
                                  ? "لا يوجد وصف متاح"
                                  : description,
                              style:
                              GoogleFonts.manrope(
                                fontSize: 16,
                                color:
                                Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// CHARITY CARD
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.charityProfileScreen,
                          );
                        },
                        child: Container(
                          margin:
                          const EdgeInsets.all(
                            18,
                          ),
                          padding:
                          const EdgeInsets.all(
                            12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                "مقدمة من",
                                style:
                                GoogleFonts.manrope(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  Colors.grey,
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      40,
                                    ),
                                    child: Image.asset(
                                      ImageAssets
                                          .ghaith,
                                      width: 60,
                                      height: 60,
                                      fit:
                                      BoxFit.cover,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    "غيث للتنمية المجتمعية",
                                    style:
                                    GoogleFonts
                                        .manrope(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// DONATE BUTTON
                      Padding(
                        padding:
                        const EdgeInsets.all(18),
                        child: SizedBox(
                          width:
                          double.infinity,
                          child: ElevatedButton(
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              const Color(
                                0xff2F674D,
                              ),
                              foregroundColor:
                              Colors.white,
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                vertical: 14,
                              ),
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  20,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes
                                    .paymentScreen,
                              );
                            },
                            child: Text(
                              "تبرع الآن",
                              style:
                              GoogleFonts
                                  .manrope(
                                fontSize: 22,
                                fontWeight:
                                FontWeight
                                    .bold,
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
          );
        },
      ),
    );
  }

  Widget buildImage(String image) {
    if (image.startsWith("http")) {
      return Image.network(
        image,
        width: double.infinity,
        height: 292,
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) => Container(
          height: 292,
          color: Colors.grey.shade300,
          child: const Icon(
            Icons.broken_image,
          ),
        ),
      );
    }

    if (image.startsWith("/")) {
      return Image.network(
        "https://aounplatform.runasp.net$image",
        width: double.infinity,
        height: 292,
        fit: BoxFit.cover,
      );
    }

    if (image.startsWith("file://")) {
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