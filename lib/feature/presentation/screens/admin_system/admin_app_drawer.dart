import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({super.key});

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
                child: Icon(
                  Icons.person,
                  color: Color(0xff9CA3AF),
                  size: 36,
              )
          ),
          const SizedBox(height: 15),

          const Text(
            "إدارة الجمعيات ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFF333333),
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
                    Navigator.pushNamed(context, Routes.adminHome);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.reqCharity,
                  "طلبات الجمعيات",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.reqCharity);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.acceptCharity,
                  "الجمعيات المقبولة ",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.acceptCharity);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.deleteCharity,
                  "الجمعيات المرفوضة ",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.unacceptCharity);
                  },
                ),
                _buildDrawerItem(
                  context,
                  ImageAssets.setIcon,
                  "الاعدادات",

                  onTap: () {
                    Navigator.pushNamed(context, Routes.setting);
                  },
                ),

                SizedBox(height: 30),
                _buildDrawerItem(
                  context,
                  ImageAssets.logout,
                  "تسجيل الخروج",
                  color: Color(0xffDC2626),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.adminLoginScreen);
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
        width: 28,
        height: 28,
        color: title == "تسجيل الخروج"
            ? Color(0xffDC2626)
            : const Color(0xff6C7072),
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
