import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../donor_system/donation_field_screen.dart';
import '../widget/field_item.dart';

class DonationTab extends StatefulWidget {
  const DonationTab({super.key});

  @override
  State<DonationTab> createState() => _DonationTabState();
}

class _DonationTabState extends State<DonationTab> {
  List<Map<String, String>> allFields = [
    {"title": "الصحة", "image": ImageAssets.healthCheck},
    {"title": "الإغاثة", "image": ImageAssets.siren},
    {"title": "التعليم", "image": ImageAssets.classroom},
    {"title": "كفالات", "image": ImageAssets.socialCare},
    {"title": "مشاريع بناء", "image": ImageAssets.brickWall},
    {"title": "التنمية", "image": ImageAssets.people},
    {"title": "ذوى الاحتياجات", "image": ImageAssets.elderly},
    {"title": "كفارات", "image": ImageAssets.elderly},
    {"title": "الغارمين", "image": ImageAssets.debt},
    {"title": "الإطعام", "image": ImageAssets.deliveryMan},
  ];

  List<Map<String, String>> filteredFields = [];

  @override
  void initState() {
    filteredFields = allFields;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),

      appBar: AppBar(
        title: Text(
          "مجالات التبرع",
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.homePage);
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filteredFields =
                      allFields.where((field) {
                        return field["title"]!.toLowerCase().contains(
                          value.toLowerCase(),
                        );
                      }).toList();
                });
              },
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffDBE4E1),
                hintText: "البحث",
                hintStyle: const TextStyle(
                  color: Color(0xffA0A0A0),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff2F674D),
                  size: 26,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                ),
              ),
            ),
          ),

          Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredFields.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return FieldItem(
                  title: filteredFields[index]["title"]!,
                  image: filteredFields[index]["image"]!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DonationFieldScreen(
                              fieldName: filteredFields[index]["title"]!,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Directionality(
            textDirection: TextDirection.rtl,

            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffD4E1DB),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    "﴿إِن تُقۡرِضُوا۟ ٱللَّهَ قَرۡضًا حَسَنࣰا یُضَـٰعِفۡهُ لَكُمۡ \n وَیَغۡفِرۡ لَكُمۡۚ وَٱللَّهُ شَكُورٌ حَلِیمٌ﴾ 🌿",
                    style: TextStyle(
                      color: Color(0xff2F5142),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
