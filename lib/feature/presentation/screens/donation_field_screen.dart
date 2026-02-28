import 'package:aoun/feature/presentation/screens/widget/case_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';


class DonationFieldScreen extends StatefulWidget {
  final String fieldName;
  DonationFieldScreen({super.key,required this.fieldName,});

  @override
  State<DonationFieldScreen> createState() => _DonationFieldScreenState();
}

class _DonationFieldScreenState extends State<DonationFieldScreen> {
  final List<Map<String, dynamic>> cases = [


    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.6,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة",
    },
    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.2,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة جداً",
    },
    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.2,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة جداً",
    },

    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 1.0,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "مكتملة",
    },
    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 0.6,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "عاجلة",
    },
    {
      "image":ImageAssets.caseRec,
      "title": "أحمد يحتاج عملية زراعة قوقعة عاجلة",
      "description": "طفل يبلغ من العمر 8 سنوات يحتاج إلى عملية زراعة\n قوقعة عاجلة لإنقاذ حياته ",
      "rateValue": 1.0,
      "collectedValue":"٨٩٠٠",
      "allValue": "١٨,٠٠٠",
      "status": "مكتملة",
    },
  ];
  List<Map<String, dynamic>> get filteredCases {
    if (selectedFilter == "الكل") {
      return cases
          .where((c) => c["status"] != "مكتملة")
          .toList();
    } else {
      return cases
          .where((c) => c["status"] == selectedFilter)
          .toList();
    }
  }
  String selectedFilter = "الكل";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 189,
          shape: OutlineInputBorder(
            borderRadius:BorderRadius.only(bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35)),
            borderSide: BorderSide(color: Color(0xff2F674D))
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white,
              size: 40,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                Image(image: AssetImage(ImageAssets.icon)),
                SizedBox(width: 8,),
                Text("مجال ${widget.fieldName}",
                    style:GoogleFonts.manrope(
                      fontSize: 26,
                      fontWeight: FontWeight.w700, // SemiBold
                      color:  Colors.white,
                    ) ,),
              ],
            ),
          ),
        ),

        body: ListView(
          children: [Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff287A54),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("نعمل على توفير الرعاية الطبية والأدوية \nاللازمة والعمليات الجراحية العاجلة لمن \nهم فى أمس الحاجة إليها ، مساهمتك\n  تنقذ حياة !",
                        style:GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w400, // SemiBold
                          color:  Colors.white,
                        ) ,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF8FAF9A),
                            borderRadius: BorderRadius.circular(45)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                        margin: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                        child: Row(
                          children: [
                            Text("حالات مكتملة ",
                              style:GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w600, // SemiBold
                                color:  Color(0xff287A54),
                              ) ,),
                            Spacer(),
                            Text("240 حالة",
                              style:GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w600, // SemiBold
                                color:  Color(0xff287A54),
                              ) ,),

                          ],
                        ),),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF8FAF9A),
                            borderRadius: BorderRadius.circular(45)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                        margin: EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                        child: Row(
                          children: [
                            Text("متبرع",
                              style:GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w600, // SemiBold
                                color:  Color(0xff287A54),
                              ) ,),
                            Spacer(),
                            Text("1800+",
                              style:GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w600, // SemiBold
                                color:  Color(0xff287A54),
                              ) ,),

                          ],
                        ),),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(

                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffB0BDB2),
                    hintText: "البحث",
                    hintStyle: const TextStyle(
                      color: Color(0xff757575),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    prefixIcon: const Icon(Icons.search,
                        color: Color(0xff2F674D), size: 26),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      const BorderSide(color: Color(0xffE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      const BorderSide(color: Color(0xffE0E0E0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
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

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
              ),
            ],
          ),],
        )
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
          color: isSelected ? const Color(0xff2F674D) :  Colors.white,
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
