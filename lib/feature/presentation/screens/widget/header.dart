import 'package:aoun/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final double titleFontSize;
  final double subtitleFontSize;

  const Header({
    super.key,
    required this.titleFontSize,
    required this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff2F674D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Image.asset(
                  ImageAssets.charityIcon,
                  width: 32,
                  height: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 22),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "بيانات الجمعيات",
                    style: GoogleFonts.manrope(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "لوحة التحكم",
                    style: GoogleFonts.manrope(
                      fontSize: subtitleFontSize,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}