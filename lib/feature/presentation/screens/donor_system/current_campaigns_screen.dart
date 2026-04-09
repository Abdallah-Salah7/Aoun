import 'package:aoun/feature/presentation/screens/widget/campaign_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';

class CurrentCampaignsScreen extends StatefulWidget {
  final String fieldName;
  CurrentCampaignsScreen({super.key, required this.fieldName});

  @override
  State<CurrentCampaignsScreen> createState() => _CurrentCampaignsScreenState();
}

class _CurrentCampaignsScreenState extends State<CurrentCampaignsScreen> {
  final List<Map<String, dynamic>> camps = [
    {
      "image": ImageAssets.gaza,
      "title": "حملة إغاثة غزة",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.water,
      "title": "حملة إغاثة غزة",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.camp1,
      "title": "حملة دفء الشتاء",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.water,
      "title": "حملة سقيا الماء ",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.camp2,
      "title": "حملة بناء وتعمير",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.camp3,
      "title": "حملة دعم مرضى السرطان",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
    {
      "image": ImageAssets.gaza,
      "title": "حملة إغاثة غزة",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 162,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 38.0, right: 80),
            child: Row(
              children: [
                Text(
                  "الحملات",
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700, // SemiBold
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),

        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: camps.length,
                  itemBuilder: (context, index) {
                    final caseItem = camps[index];

                    return CampaignItem(
                      image: caseItem["image"],
                      title: caseItem["title"],
                      rateValue: caseItem["rateValue"],
                      collectedValue: caseItem["collectedValue"],
                      allValue: caseItem["allValue"],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
