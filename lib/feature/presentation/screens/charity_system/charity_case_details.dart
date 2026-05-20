import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/case_entity.dart';
import '../widget/weekly_chart.dart';

class CharityCaseDetails extends StatefulWidget {
  final CaseEntity caseData;

  const CharityCaseDetails({super.key, required this.caseData});

  @override
  State<CharityCaseDetails> createState() => _CharityCaseDetailsState();
}

class _CharityCaseDetailsState extends State<CharityCaseDetails> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final image = widget.caseData.image;
    final title = widget.caseData.title;
    final rateValue = widget.caseData.rateValue;
    final collectedValue = widget.caseData.collectedValue;
    final allValue = widget.caseData.allValue;
    final status = widget.caseData.status;
    final description = widget.caseData.description;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text(
            "  تفاصيل الحالة ",
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
                          "وصف الحالة",
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
}
