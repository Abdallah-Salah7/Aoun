import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/charity_system/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharityProf extends StatelessWidget {
  const CharityProf({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double w(double value) => width * value;
    double h(double value) => height * value;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: const Color(0xFFD9DDDA),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                height: h(0.1),
                decoration: const BoxDecoration(
                  color: Color(0xff2F674D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: w(0.08),
                  vertical: h(0.01),
                ),
                child: Row(
                  children: [
                    Builder(
                      builder:
                          (context) => InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Image.asset(
                              ImageAssets.charityIcon,
                              width: w(0.1),
                            ),
                          ),
                    ),
                    SizedBox(width: w(0.05)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "الاعدادات",
                          style: GoogleFonts.manrope(
                            fontSize: w(0.05),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "لوحة التحكم",
                          style: GoogleFonts.manrope(
                            fontSize: w(0.045),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: h(0.02)),

              CircleAvatar(
                radius: w(0.1),
                backgroundImage: AssetImage(ImageAssets.ghaith),
              ),

              SizedBox(height: h(0.015)),

              const Text(
                "غيث للتنمية المجتمعية",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF333333),
                ),
              ),

              SizedBox(height: h(0.02)),

              // MENU BOX
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: h(0.03),
                  horizontal: w(0.03),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildItem(
                      context,
                      icon: ImageAssets.history,
                      title: "سجل التبرعات",
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.donationRecord,
                          ),
                      w: w,
                    ),
                    _buildItem(
                      context,
                      icon: ImageAssets.fav,
                      title: "العناصر المحفوظة",
                      onTap:
                          () => Navigator.pushNamed(context, Routes.savedCases),
                      w: w,
                    ),
                    _buildItem(
                      context,
                      icon: ImageAssets.setting,
                      title: "الاعدادات",
                      onTap:
                          () => Navigator.pushNamed(context, Routes.settings),
                      w: w,
                    ),
                    _buildItem(
                      context,
                      icon: ImageAssets.security,
                      title: "الخصوصية والأمان",
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.privacyAndSecurity,
                          ),
                      w: w,
                      showBorder: false,
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

  Widget _buildItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    required double Function(double) w,
    bool showBorder = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border:
              showBorder
                  ? const Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  )
                  : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffE5EBE9),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Image.asset(icon, height: 28, width: 28),
            ),
            SizedBox(width: w(0.03)),
            Text(
              title,
              style: GoogleFonts.saira(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xff342821),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }
}
