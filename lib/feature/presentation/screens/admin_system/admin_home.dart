import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import 'admin_app_drawer.dart';
import 'data_chart.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AdminAppDrawer(),
        backgroundColor: const Color(0xffC7CDCD),

        body: CustomScrollView(
          slivers: [

            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff2F674D),
              expandedHeight: 120,
              toolbarHeight: 120,
              elevation: 0,
              clipBehavior: Clip.hardEdge,

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),

              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),

                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// menu icon
                      Builder(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Image.asset(
                              ImageAssets.charityIcon,
                              width: 32,
                              height: 32,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 22),


                      /// title
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "إدارة الجمعيات",
                            style: GoogleFonts.manrope(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "لوحة التحكم",
                            style: GoogleFonts.manrope(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      /// notification
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            ImageAssets.bell,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),

                          Positioned(
                            left: 1,
                            top: -1,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xff6DDA6F),
                                shape: BoxShape.circle,
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        "الإحصائيات",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3F0EA),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                margin: EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.totalCharity),
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "إجمالى عدد الجمعيات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff6A6969),
                                  ),
                                ),
                                Text(
                                  "8 جمعيات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3F0EA),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                margin: EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.acceptCharity),
                                  height: 40,
                                  width: 40,
                                  color: Color(0xff255A41),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "عدد الجمعيات المقبولة",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff6A6969),
                                  ),
                                ),
                                Text(
                                  "8 جمعيات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3F0EA),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                margin: EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.deleteCharity),
                                  height: 40,
                                  width: 40,
                                  color: Color(0xff255A41),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "عدد الجمعيات المرفوضة",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff6A6969),
                                  ),
                                ),
                                Text(
                                  "8 جمعيات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3F0EA),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                margin: EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.stopCharity),
                                  height: 40,
                                  width: 40,
                                  color: Color(0xff255A41),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "عدد الجمعيات الموقوفة",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff6A6969),
                                  ),
                                ),
                                Text(
                                  "8 جمعيات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        "عدد التسجيلات الجديدة ",
                        style: GoogleFonts.manrope(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    DataChart(),
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
