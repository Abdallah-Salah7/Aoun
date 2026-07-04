import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/admin_system/req_charity_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import 'admin_app_drawer.dart';

class ReqCharity extends StatelessWidget {
  const ReqCharity({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                  padding: const EdgeInsets.symmetric(horizontal: 22),

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
                            "طلبات الجمعيات",
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
              child: Column(
                children: [
                  ReqCharityItem(
                    charityName: "جمعية غيث للتنمية المجتمعية",
                    applicationDate: "12/11/2026",
                    onDetailsPressed: () {
                      Navigator.pushNamed(context, Routes.reqCharityReview);
                    },
                  ),
                  ReqCharityItem(
                    charityName: "جمعية غيث للتنمية المجتمعية",
                    applicationDate: "12/11/2026",
                    onDetailsPressed: () {
                      // Navigate to details screen
                    },
                  ),
                  ReqCharityItem(
                    charityName: "جمعية غيث للتنمية المجتمعية",
                    applicationDate: "12/11/2026",
                    onDetailsPressed: () {
                      // Navigate to details screen
                    },
                  ),
                  ReqCharityItem(
                    charityName: "جمعية غيث للتنمية المجتمعية",
                    applicationDate: "12/11/2026",
                    onDetailsPressed: () {
                      Navigator.pushNamed(context, Routes.reqCharityReview);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
