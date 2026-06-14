import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class DonationRecord extends StatelessWidget {
  const DonationRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

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
          title: Text("سجل التبرعات",
          style: GoogleFonts.saira(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color(0xff255A41)
          ),
          ),
        ),

        body: Column(
          children: [
            SizedBox(height: 75,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 23,
                ),

                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading:  ClipOval(
                          child: Image(
                            image: AssetImage(ImageAssets.caseRec),
                            height: 55,
                            width: 55,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title:
                        Text(
                          "بناء مسجد فى قرية نائية",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff342821),
                          ),
                        ),
                          subtitle:
                          Text(
                            "1/3/2026",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff747575),
                            ),
                          ),
                          trailing:
                          Text("500 ج.م",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff255A41),
                            ),
                          )

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                          leading:  ClipOval(
                            child: Image(
                              image: AssetImage(ImageAssets.caseRec),
                              height: 55,
                              width: 55,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title:
                          Text(
                            "بناء مسجد فى قرية نائية",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff342821),
                            ),
                          ),
                          subtitle:
                          Text(
                            "1/3/2026",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff747575),
                            ),
                          ),
                          trailing:
                          Text("500 ج.م",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff255A41),
                            ),
                          )

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                          leading:  ClipOval(
                            child: Image(
                              image: AssetImage(ImageAssets.caseRec),
                              height: 55,
                              width: 55,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title:
                          Text(
                            "بناء مسجد فى قرية نائية",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff342821),
                            ),
                          ),
                          subtitle:
                          Text(
                            "1/3/2026",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff747575),
                            ),
                          ),
                          trailing:
                          Text("500 ج.م",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff255A41),
                            ),
                          )

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                          leading:  ClipOval(
                            child: Image(
                              image: AssetImage(ImageAssets.caseRec),
                              height: 55,
                              width: 55,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title:
                          Text(
                            "بناء مسجد فى قرية نائية",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff342821),
                            ),
                          ),
                          subtitle:
                          Text(
                            "1/3/2026",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff747575),
                            ),
                          ),
                          trailing:
                          Text("500 ج.م",
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff255A41),
                            ),
                          )

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
