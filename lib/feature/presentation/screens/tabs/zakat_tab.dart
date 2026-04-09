import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class ZakatTab extends StatelessWidget {
  const ZakatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 167,
          shape: OutlineInputBorder(
              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
              borderSide: BorderSide(color: Color(0xff2F674D))
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Row(
              children: [
                Text("حاسبة الزكاة",
                  style:GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700, // SemiBold
                    color:  Colors.white,
                  ) ,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                  child: Text("خدماتنا",
                    style:GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w900, // SemiBold
                    ) ,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){

                        Navigator.pushNamed(
                          context,
                          Routes.calcZakat,
                        );
                      },
                      child: Expanded(
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
                          height: 176,
                          width: 167,
                          padding: EdgeInsets.only(top: 28,),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5D7CF),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  width: 55,
                                  height: 55,
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.calcZakat),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "احسب زكاتك",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 18,),
                    InkWell(
                      onTap: (){

                        Navigator.pushNamed(
                          context,
                          Routes.fatwasOnZakatScreen,
                        );
                      },
                      child: Expanded(
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
                          height: 176,
                          width: 167,
                          padding: EdgeInsets.only(top: 28,),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5D7CF),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  width: 55,
                                  height: 55,
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.rulingsZakat),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "فتاوى الزكاة",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
                SizedBox(height: 28,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){

                      },
                      child: Expanded(
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
                          height: 176,
                          width: 167,
                          padding: EdgeInsets.only(top: 28,),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5D7CF),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  width: 55,
                                  height: 55,
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.fundsZakat),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "مصارف الزكاة",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 18,),
                    InkWell(
                      onTap: (){

                      },
                      child: Expanded(
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
                          height: 176,
                          width: 167,
                          padding: EdgeInsets.only(top: 28,),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5D7CF),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  width: 55,
                                  height: 55,
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.fundsZakat),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "التواصل مع دار الإفتاء",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
