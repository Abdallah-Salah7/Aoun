import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widget/donation_chart.dart';
import '../widget/weekly_chart.dart';
import 'app_drawer.dart';


class HomeCharity extends StatelessWidget {
  const HomeCharity({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(backgroundColor: Color(0xff2F674D), toolbarHeight: 0),
        backgroundColor: Color(0xffC7CDCD),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Color(0xff2F674D),
                  ),
                  height: 148,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 32,
                    ),

                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, top: 18),
                          child: Builder(
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image(
                                  image: AssetImage(ImageAssets.charityIcon),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "غيث للتنمية المجتمعية",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800, // SemiBold
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "لوحة التحكم",
                                style: GoogleFonts.manrope(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600, // SemiBold
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 18),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                ImageAssets.bell,
                                width: 38,
                                height: 38,
                                color: Colors.white,
                              ),
                              Positioned(
                                left: 7,
                                top: 2,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2FA633),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "الإحصائيات",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w800, // SemiBold
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffE3F0EA),

                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Image(
                                        image: AssetImage(
                                          ImageAssets.totalDonation,
                                        ),
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "إجمالى التبرعات",
                                      style: GoogleFonts.manrope(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800, // SemiBold
                                        color: Color(0xff6A6969),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " 452,000 ج.م\n",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 28),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffE3F0EA),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Image(
                                        image: AssetImage(
                                          ImageAssets.numDonors,
                                        ),
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "عدد المتبرعين",
                                      style: GoogleFonts.manrope(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800, // SemiBold
                                        color: Color(0xff6A6969),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "3250 متبرع\n",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffE3F0EA),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Image(
                                        image: AssetImage(ImageAssets.numCases),
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "عدد الحالات",
                                      style: GoogleFonts.manrope(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800, // SemiBold
                                        color: Color(0xff6A6969),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "235 حالة\n",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 28),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffE3F0EA),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Image(
                                        image: AssetImage(ImageAssets.numCases),
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "عدد الحملات",
                                      style: GoogleFonts.manrope(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800, // SemiBold
                                        color: Color(0xff6A6969),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " 20 حملة\n",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          top: 18,
                          bottom: 18,
                        ),
                        child: Text(
                          "التحليلات",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w800, // SemiBold
                          ),
                        ),
                      ),
                      WeeklyChart(),
                      SizedBox(height: 18),
                      DonationChart(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 35.0,
                          horizontal: 7,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E5631),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(width: 12),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "صندوق الطوارئ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "الرصيد المتاح: 4500 ج.م",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.north_west,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "عرض التفاصيل",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                           children: [
                             Text("النشاط الأخير",
                             style: TextStyle(
                               fontSize: 22,
                               fontWeight: FontWeight.w800
                             ),),
                             Spacer(),
                             InkWell(
                               onTap: (){

                               },
                               child: Text("عرض المزيد",
                                 style: TextStyle(
                                     fontSize: 22,
                                     fontWeight: FontWeight.w800,
                                   color: Color(0xff248457)
                                 ),),
                             )
                           ],
                        ),
                      ),
                      Container(
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
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                              ),
                              subtitle: const Text("علاج طفل مريض",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),),
                              trailing: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "500 ج.م",
                                    style: TextStyle(
                                      color: Color(0xff255A41),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                    ),
                                  ),
                                  Text(
                                    "منذ 5 دقائق",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,

                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
