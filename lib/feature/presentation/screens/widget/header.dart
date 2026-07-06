import 'package:aoun/core/color_manager/app_color.dart';
import 'package:aoun/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final double titleFontSize;
  final double subtitleFontSize;

  const Header({required this.titleFontSize, required this.subtitleFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Intrinsic height driven by content + padding instead of a fixed
      // height, so it won't overflow when the user increases text scale.
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(
            builder:
                (context) => InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image.asset(
                    ImageAssets.charityIcon,
                    width: 30,
                    height: 30,
                  ),
                ),
          ),
          const Spacer(),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "بيانات الجمعية",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: titleFontSize * 0.9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "لوحة التحكم",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                top: 11,
                right: 25,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}