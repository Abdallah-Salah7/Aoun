import 'package:aoun/feature/presentation/screens/widget/campaign_item.dart';
import 'package:aoun/feature/presentation/screens/widget/case_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';

class CharityProfileScreen extends StatefulWidget {
  const CharityProfileScreen({super.key});

  @override
  State<CharityProfileScreen> createState() => _CharityProfileScreenState();
}

class _CharityProfileScreenState extends State<CharityProfileScreen> {
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
      "image": ImageAssets.gaza,
      "title": "حملة إغاثة غزة",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
    },
  ];

  final List<Map<String, dynamic>> cases = [
    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة",
    },
    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.2,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة جداً",
    },
    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.2,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة جداً",
    },

    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 1.0,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "مكتملة",
    },
    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.6,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة",
    },
    {
      "image": ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description":
          "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 1.0,
      "collectedValue": "٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "مكتملة",
    },
  ];
  List<Map<String, dynamic>> get filteredCases {
    if (selectedFilter == "الحالات") {
      return cases.where((c) => c["status"] != "مكتملة").toList();
    }
    return [];
  }

  String selectedFilter = "الحالات";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "غيث للتنمية المجتمعية",
            style: GoogleFonts.manrope(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C5240),
            ),
          ),
          titleSpacing: 0,
          centerTitle: false,
        ),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Image(
                        image: AssetImage(ImageAssets.ghaith),
                        fit: BoxFit.cover,
                        width: 105,
                        height: 105,
                      ),
                    ),
                  ),
                  Text(
                    "غيث للتنمية المجتمعية",
                    style: GoogleFonts.manrope(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2C5240),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD4E1DB),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 172,
                          height: 69,
                          margin: EdgeInsets.only(right: 25, left: 6, top: 27),
                          child: Center(
                            child: Text(
                              "1500+\nمستفيد",
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff2C5240),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD4E1DB),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 172,
                          height: 69,
                          margin: EdgeInsets.only(left: 25, right: 6, top: 27),
                          child: Center(
                            child: Text(
                              "1000+\nمتبرع",
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff2C5240),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " عن الجمعية",
                          style: GoogleFonts.manrope(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "جمعية خيرية متخصصة فى تقديم الرعاية الصحية والدعم\n الطبى للأطفال المحتاجين.\n نعمل منذ 2015 على تحسين حياة الأطفال\n وعائلاتهم من خلال توفير العلاج والرعاية اللازمة ",
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E1DB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text(
                          "خزنة الطوارئ",
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff2C5240),
                          ),
                        ),
                        Spacer(),
                        Image(
                          image: AssetImage(ImageAssets.emergency),
                          height: 71,
                          width: 82,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 15,
                    ),
                    child: Text(
                      "مجالات العمل",
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffBFDCCF),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            padding: const EdgeInsets.only(
                              top: 6.0,
                              bottom: 8,
                              right: 15,
                              left: 40,
                            ),

                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage((ImageAssets.siren)),
                                    width: 20,
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      right: 8,
                                    ),
                                    child: Text(
                                      "الإغاثة",
                                      style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffBFDCCF),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            padding: const EdgeInsets.only(
                              top: 6.0,
                              bottom: 8,
                              right: 15,
                              left: 40,
                            ),

                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage((ImageAssets.elderly)),
                                    width: 20,
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      right: 8,
                                    ),
                                    child: Text(
                                      "ذوى الاحتياجات",
                                      style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffBFDCCF),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            padding: const EdgeInsets.only(
                              top: 6.0,
                              bottom: 8,
                              right: 15,
                              left: 40,
                            ),

                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage((ImageAssets.brickWall)),
                                    width: 20,
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      right: 8,
                                    ),
                                    child: Text(
                                      "مشاريع بناء",
                                      style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 45.0,
                      horizontal: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD4E1DB),
                        border: Border.all(
                          color: const Color(0xff2F674D),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: buildFilterButton("الحالات")),
                          Expanded(child: buildFilterButton("الحملات")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  selectedFilter == "الحالات"
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCases.length,
                        itemBuilder: (context, index) {
                          final caseItem = filteredCases[index];

                          return CaseItem(
                            image: caseItem["image"],
                            title: caseItem["title"],
                            description: caseItem["description"],
                            rateValue: caseItem["rateValue"],
                            collectedValue: caseItem["collectedValue"],
                            allValue: caseItem["allValue"],
                            status: caseItem["status"],
                          );
                        },
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: camps.length,
                        itemBuilder: (context, index) {
                          final campItem = camps[index];

                          return CampaignItem(
                            image: campItem["image"],
                            title: campItem["title"],
                            rateValue: campItem["rateValue"],
                            collectedValue: campItem["collectedValue"],
                            allValue: campItem["allValue"],
                          );
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final bool isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F674D) : Colors.white,
          borderRadius:
              title == "الحالات"
                  ? const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                  : const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xff2F674D),
          ),
        ),
      ),
    );
  }
}
