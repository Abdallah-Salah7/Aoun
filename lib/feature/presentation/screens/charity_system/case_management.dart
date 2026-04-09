import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../widget/case_item.dart';
import '../widget/charity_case_item.dart';
import '../widget/field_dropdown.dart';
import 'app_drawer.dart';

class CaseManagement extends StatefulWidget {
  const CaseManagement({super.key});

  @override
  State<CaseManagement> createState() => _CaseManagementState();
}

class _CaseManagementState extends State<CaseManagement> {
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
    if (selectedFilter == "الكل") {
      return cases.where((c) => c["status"] != "مكتملة").toList();
    } else {
      return cases.where((c) => c["status"] == selectedFilter).toList();
    }
  }
  String selectedFilter = "الكل";
  String selectedCategory = "الصحة"; // default
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addCase,
              );
            },
            backgroundColor: Color(0xff2F674D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        drawer: const AppDrawer(),
        appBar: AppBar(backgroundColor: Color(0xff2F674D), toolbarHeight: 0),
        backgroundColor: Color(0xffC7CDCD),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Color(0xff2F674D),
                  ),
                  height: 148,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 32,
                    ),

                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, top: 18),
                          child: Builder(
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image(
                                  image: AssetImage(ImageAssets.charityIcon),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "إدارة الحالات",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800, // SemiBold
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "لوحة التحكم",
                                style: GoogleFonts.manrope(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400, // SemiBold
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18,left: 18,top: 18,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildFilterButton("الكل"),
                      buildFilterButton("عاجلة جداً"),
                      buildFilterButton("مكتملة"),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: FieldDropdown(
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value ?? "الصحة";
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],

                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 28,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffE3F0EA),

                              borderRadius: BorderRadius.circular(45),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Image(
                              image: AssetImage(
                                ImageAssets.totalDonation,
                              ),
                              height: 36,
                              width: 36,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "إجمالى التبرعات",
                                    style: GoogleFonts.manrope(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800, // SemiBold
                                      color: Color(0xff6A6969),
                                    ),
                                  ),
                                ),
                                Text(
                                  "  452,000 ج.م   \n",
                                  style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(0, 6),
                              ),
                            ],

                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE3F0EA),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.numCases),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "عدد الحالات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800, // SemiBold
                                    color: Color(0xff6A6969),
                                  ),
                                ),
                              ),
                              Text(
                                "235 حالة\n",
                                style: GoogleFonts.manrope(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 28),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(0, 6),
                              ),
                            ],

                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE3F0EA),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.numDonors),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "عدد المتبرعين",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800, // SemiBold
                                    color: Color(0xff6A6969),
                                  ),
                                ),
                              ),
                              Text(
                                " 3250 متبرع \n",
                                style: GoogleFonts.manrope(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredCases.length,
                  itemBuilder: (context, index) {
                    final caseItem = filteredCases[index];

                     return CharityCaseItem(
                      image: caseItem["image"],
                      title: caseItem["title"],
                      description: caseItem["description"],
                      rateValue: caseItem["rateValue"],
                      collectedValue: caseItem["collectedValue"],
                      allValue: caseItem["allValue"],
                      status: caseItem["status"],
                      category: selectedCategory, // 🔥 الجديد
                    );
                  },
                ),


              ],
            )
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
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F674D) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
