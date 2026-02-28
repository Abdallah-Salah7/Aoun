import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/routes_manager/routes.dart';

class CaseDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const CaseDetailsScreen({super.key, required this.args});

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final image = widget.args["image"];
    final title = widget.args["title"];
    final rateValue = widget.args["rateValue"];
    final collectedValue = widget.args["collectedValue"];
    final allValue = widget.args["allValue"];
    final status = widget.args["status"];

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
                      Image.asset(image),
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

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
                          status == "مكتملة"
                              ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Align(
                              alignment:  Alignment.topRight,
                              child: Text("تم جمع 100%",
                                style: GoogleFonts.manrope(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff757575),
                                ),
                              ),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                Text(
                                  "تم جمع $collectedValue ج.م",
                                  style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff757575),
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
                                  "١٢٥ متبرع",
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
                          "تفاصيل الحالة",
                          style: GoogleFonts.manrope(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "أحمد طفل يعاني من فقدان سمع شديد\n ويحتاج بشكل عاجل إلى عملية زراعة\n قوقعة ليستطيع السمع والتواصل مع من\n حوله.  أكد الأطباء أن إجراء العملية في أقرب\n وقت ضروري لتحسين قدرته على النطق\n والتعلم.  تكلفة العملية والعلاج تفوق إمكانيات\n أسرته، وتبرعك يساهم في منح أحمد فرصة\n حقيقية لحياة أفضل ومستقبل مليء\n بالأمل.",
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
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                              SizedBox(width: 8,),
                              Text(
                                "غيث للتنمية المجتمعية",
                                style: GoogleFonts.manrope(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff757575),
                                ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: status == "مكتملة"
                          ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff8FAF9A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "اكتملت",
                              style: GoogleFonts.manrope(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.check_circle_outline,
                                color: Colors.white, size: 36),


                          ],
                        ),
                      )
                          : SizedBox(
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
                            Navigator.pushNamed(
                                context, Routes.paymentScreen);
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
}
