import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../widget/weekly_chart.dart';

class CharityCampaignDetails extends StatefulWidget {
  final CampaignEntity campaignData;

  const CharityCampaignDetails({super.key, required this.campaignData});

  @override
  State<CharityCampaignDetails> createState() => _CharityCampaignDetailsState();
}

class _CharityCampaignDetailsState extends State<CharityCampaignDetails> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final image = widget.campaignData.image;
    final title = widget.campaignData.title;
    final rateValue = widget.campaignData.rateValue;
    final collectedValue = widget.campaignData.collectedValue;
    final allValue = widget.campaignData.allValue;
    final status = widget.campaignData.status;
    final description = widget.campaignData.description;
    final endDate = widget.campaignData.endDate;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text(
            "  تفاصيل الحملة ",
            style: GoogleFonts.manrope(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.black,
            ),
          ),
          toolbarHeight: 70,
        ),

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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image:
                                  image.startsWith('/') ||
                                          image.contains('cache')
                                      ? FileImage(File(image))
                                      : AssetImage(image) as ImageProvider,
                              fit: BoxFit.fill,
                              height: 198,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 28.0,
                        ),
                        child: Text(
                          title,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 28,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image(
                                    image: AssetImage(ImageAssets.iconDate),
                                    height: 34,
                                    width: 34,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${getRemainingDays()} يوم متبقى",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 8.0,
                                ),
                                child: Text(
                                  title,
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: rateValue,
                                minHeight: 8,
                                backgroundColor: Color(0xffCFCFCF),
                                color: Color(0xff2F5D46),
                              ),
                            ),

                            SizedBox(height: 14),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "تم جمع $collectedValue ج.م",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff2F5D46),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "من $allValue",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff6E6E6E),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Icon(Icons.group, color: Color(0xff2F5D46)),
                                    SizedBox(width: 6),
                                    Text(
                                      "١٢٥ متبرع",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff6E6E6E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "وصف الحملة",
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
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
                            description,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDateBox(
                            title: "بداية الحملة",
                            date: widget.campaignData.startDate,
                          ),
                          _buildDateBox(
                            title: "نهاية الحملة",
                            date: widget.campaignData.endDate,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 18,
                      ),
                      child: WeeklyChart(title: "نمو التبرعات"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "آخر التبرعات",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10),
                          ],
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 6,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: Color(0xffC7CDCD),
                                child: const Text(
                                  "م",
                                  style: TextStyle(
                                    color: Color(0xFF1E5631),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "محمد أحمد",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: const Text(
                                "منذ 5 دقائق",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "500 ج.م",
                                    style: TextStyle(
                                      color: Color(0xff255A41),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getRemainingDays() {
    final now = DateTime.now();
    final difference = widget.campaignData.endDate.difference(now).inDays;

    return difference < 0 ? 0 : difference;
  }

  Widget _buildDateBox({required String title, required DateTime? date}) {
    String formattedDate =
        date == null ? "--/--/----" : "${date.day}/${date.month}/${date.year}";

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffC4C4C4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            formattedDate,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
