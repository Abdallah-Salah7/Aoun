import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class CalcZakat extends StatelessWidget {
  const CalcZakat({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 168,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                SizedBox(width: 8),
                Text(
                  "حاسبة الزكاة",
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700, // SemiBold
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Align(
            alignment: Alignment.topRight,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8,
                  ),
                  child: Text(
                    "خدماتنا",
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w900, // SemiBold
                    ),
                  ),
                ),
                SizedBox(height: 22),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.zakatMoney);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffD4E1DB),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffB8CFC5),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image(
                            image: AssetImage(ImageAssets.money),
                            height: 28,
                            width: 28,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Text(
                          "زكاة المال",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xff342821),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 42),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.zakatGold);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffD4E1DB),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffB8CFC5),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image(
                            image: AssetImage(ImageAssets.gold),
                            height: 28,
                            width: 28,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Text(
                          "زكاة الذهب ",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xff342821),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 42),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.zakatSliver);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffD4E1DB),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffB8CFC5),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image(
                            image: AssetImage(ImageAssets.sliver),
                            height: 28,
                            width: 28,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Text(
                          "زكاة الفضة",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xff342821),
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
      ),
    );
  }
}
