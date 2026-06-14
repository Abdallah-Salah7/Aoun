import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';

class SavedCases extends StatefulWidget {
  const SavedCases({super.key});

  @override
  State<SavedCases> createState() => _SavedCasesState();
}

class _SavedCasesState extends State<SavedCases> {
  List<Map<String, dynamic>> cases = [
    {
      "title": "مساعدة طفل يتيم",
      "subtitle": "كفالة طفل يتيم في استكمال تعليمه",
      "image": "https://i.pravatar.cc/150?img=1",
      "isSaved": true,
    },
    {
      "title": "توفير أطراف صناعية",
      "subtitle": "كفالة طفل يتيم في استكمال تعليمه",
      "image": "https://i.pravatar.cc/150?img=2",
      "isSaved": true,
    },
    {
      "title": "مساعدة طفل يتيم",
      "subtitle": "كفالة طفل يتيم في استكمال تعليمه",
      "image": "https://i.pravatar.cc/150?img=3",
      "isSaved": true,
    },
    {
      "title": "مساعدة طفل يتيم",
      "subtitle": "كفالة طفل يتيم في استكمال تعليمه",
      "image": "https://i.pravatar.cc/150?img=1",
      "isSaved": true,
    },
  ];

  void toggleSave(int index) {
    setState(() {
      cases.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          leading: IconButton(
            icon:  Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("العناصر المحفوظة",
            style: GoogleFonts.saira(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xff255A41)
            ),
          ),
        ),



        body: Padding(
          padding: const EdgeInsets.only(top: 68.0),
          child: ListView.builder(
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final item = cases[index];

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image(
                            image: AssetImage(ImageAssets.caseRec),
                            height: 77,
                            width: 77,
                            fit: BoxFit.fill,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: GoogleFonts.saira(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff3B3D3C),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item["subtitle"],
                                style: GoogleFonts.saira(
                                  fontSize: 16,
                                  color: Color(0xff5A5B5A),
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => toggleSave(index),
                          child: Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff2F674D),
                                width: 1.5
                              ),
                            ),
                            child: const Icon(
                              Icons.bookmark,
                              color: Color(0xff2F674D),
                              size: 38,
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    height: 1,
                    color: const Color(0xff2E6B4F).withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}