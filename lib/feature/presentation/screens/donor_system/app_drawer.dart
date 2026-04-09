import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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

          const Text(
            "غيث للتنمية المجتمعية",
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
                ),
                _buildDrawerItem(context, ImageAssets.homee, "الحالات"),
                _buildDrawerItem(context, ImageAssets.homee, "الحملات"),
                _buildDrawerItem(context, ImageAssets.homee, "عرض التقارير"),
                _buildDrawerItem(context, ImageAssets.homee, "مساعد عون"),
                _buildDrawerItem(context, ImageAssets.homee, "المتبرعين"),
                _buildDrawerItem(context, ImageAssets.homee, "الاعدادات"),

                SizedBox(height: 30,),
                _buildDrawerItem(
                  context,
                  ImageAssets.logout,
                  "تسجيل الخروج",
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        Routes.donorLoginScreen);
                  }
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
        width: 24,
        height: 24,
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