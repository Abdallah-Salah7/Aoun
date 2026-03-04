import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';

class CharityProfileScreen extends StatelessWidget {
  const CharityProfileScreen({super.key});

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
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage(ImageAssets.more),
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                        color: Color(0xffC9D6CC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 172,
                      height: 69,
                      margin: EdgeInsets.only(right: 14, left: 6, top: 22),
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
                        color: Color(0xffC9D6CC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 172,
                      height: 69,
                      margin: EdgeInsets.only(left: 14, right: 6, top: 22),
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
                margin: EdgeInsets.all(18),
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
                    Text("جمعية خيرية متخصصة فى تقديم الرعاية الصحية والدعم\n الطبى للأطفال المحتاجين.\n نعمل منذ 2015 على تحسين حياة الأطفال\n وعائلاتهم من خلال توفير العلاج والرعاية اللازمة ",
                        style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
