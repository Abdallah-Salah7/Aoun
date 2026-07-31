import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String charityName = "اسم الجمعية";

  @override
  void initState() {
    super.initState();
    loadCharityName();
  }

  Future<void> loadCharityName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      charityName =
          prefs.getString("charityName") ?? "اسم الجمعية";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 60),
          CircleAvatar(
            radius: 40, // نص 73
            backgroundImage: AssetImage(ImageAssets.ghaith),
          ),
          const SizedBox(height: 15),

          SizedBox(
            width: 220,
            child: Text(
              charityName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF333333),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // العناصر
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildDrawerItem(
                  context,
                  ImageAssets.homee,
                  "الرئيسية",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.homeCharity);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.caseIcon,
                  "الحالات",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.caseManagement);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.campIcon,
                  "الحملات",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.campaignManagement);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.repoIcon,
                  "عرض التقارير",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.charityReportsScreen);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.chatIcon,
                  "مساعد عون",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.chatBotScreen);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.donIcon,
                  "المتبرعين",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.donorsScreen);
                  },
                ),
                _buildDrawerItem(context, ImageAssets.setting, "الاعدادات",

                  onTap: () {
                    Navigator.pushNamed(context, Routes.charitySettingsScreen);
                  },),

                SizedBox(height: 30),
                _buildDrawerItem(
                  context,
                  ImageAssets.logout,
                  "تسجيل الخروج",
                  color: Color(0xffDC2626),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.userTypeScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      String imagePath,
      String title, {
        Color color = Colors.black87,
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 34,
        height: 34,
        color: title == "تسجيل الخروج"
            ? Color(0xffDC2626)
            : const Color(0xff2F674D),
      ),

      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),

      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
    );
  }
}
