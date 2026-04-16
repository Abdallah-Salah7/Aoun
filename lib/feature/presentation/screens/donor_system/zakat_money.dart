import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class ZakatMoney extends StatelessWidget {
  final VoidCallback onSeeMorePressed;

   ZakatMoney({super.key,required this.onSeeMorePressed});

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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image(
                    image: AssetImage(ImageAssets.money),
                    height: 29,
                    width: 29,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "زكاة المال ",
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

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 23,
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D5B),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),

                        Text(
                          "حساباتي المالية",
                          style: GoogleFonts.saira(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      "قيمة المال",
                      style: GoogleFonts.saira(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        suffixIcon: Text(
                          "ج.م",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 21),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      "دائن(أموال لك عند الغير)",
                      style: GoogleFonts.saira(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        suffixIcon: Text(
                          "ج.م",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 21),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      "مدين(أموال الغير عندك)",
                      style: GoogleFonts.saira(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        suffixIcon: Text(
                          "ج.م",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 180),
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
                          showZakatSheet(context);
                        },
                        child: Text(
                          "احسب قيمة الزكاة",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showZakatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EBE9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff83A695),width: 1.2)

                    ),
                    child: Row(
                      children: [
                        Text(
                          "إجمالى الزكاة",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black,
                          ),),
                        Spacer(),
                        Text(
                          " 5000 ج.م",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black,
                          ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onSeeMorePressed ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2F6B4F),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "تبرع الآن",
                        style: TextStyle(fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
