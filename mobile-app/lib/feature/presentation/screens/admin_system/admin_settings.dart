import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/admin_system/admin_app_drawer.dart';
import 'package:aoun/feature/presentation/screens/charity_system/app_drawer.dart';
import 'package:aoun/feature/presentation/screens/widget/custom_switch.dart';
import 'package:aoun/feature/presentation/screens/widget/security_scetion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool newDonation = true;
  bool caseCompleted = false;
  bool campaignCompleted = true;
  bool dailyReports = false;

  static const _primaryColor = Color(0xff2F674D);
  static const _backgroundColor = Color(0xffF2F2F2);
  static const _iconBgColor = Color(0xffEAF2EF);
  static const _badgeGreen = Color(0xff2FA633);
  static const _badgeTextColor = Color(0xff067A57);
  static const _arrowColor = Color(0xff43332B);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AdminAppDrawer(),
        appBar: AppBar(backgroundColor: _backgroundColor, toolbarHeight: 0),

        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, width, height),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(width * 0.055),
                  child: Column(
                    children: [
                      _buildProfileCard(size),
                      SizedBox(height: height * 0.02),
                      SizedBox(height: height * 0.02),
                      _buildNotificationsCard(size),
                      SizedBox(height: height * 0.02),
                      const SecuritySction(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader(BuildContext context, double width, double height) {
    return Container(
      height: height * 0.1,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: _primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.01,
        ),
        child: Row(
          children: [
            Builder(
              builder: (context) {
                return InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image(
                    image: AssetImage(ImageAssets.charityIcon),
                    width: width * 0.1,
                  ),
                );
              },
            ),
            SizedBox(width: width * 0.05),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "الإعدادات",
                    style: GoogleFonts.manrope(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "لوحة التحكم",
                    style: GoogleFonts.manrope(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImageAssets.bell,
                  width: width * 0.075,
                  height: width * 0.075,
                  color: Colors.white,
                ),
                Positioned(
                  left: width * 0.012,
                  top: height * 0.002,
                  child: Container(
                    width: width * 0.025,
                    height: width * 0.025,
                    decoration: const BoxDecoration(
                      color: _badgeGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // PROFILE CARD
  Widget _buildProfileCard(Size size) {
    final width = size.width;
    final height = size.height;

    return _sectionCard(
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width * 0.09,
                height: width * 0.09,
                decoration: BoxDecoration(
                  color: _iconBgColor,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/solar_settings-outline (1).png",
                  ),
                ),
              ),
              SizedBox(width: width * 0.025),
              Text(
                "إعدادات المسؤول",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),

          CircleAvatar(
            radius: width * 0.09,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: width * 0.09, color: Colors.grey),
          ),

          SizedBox(height: height * 0.015),

          Text(
            "مدير النظام",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.045,
            ),
          ),

          SizedBox(height: height * 0.005),

          Text(
            "admin@test.com",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: width * 0.037,
            ),
          ),

          SizedBox(height: height * 0.015),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.025,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "مسؤول النظام",
              style: TextStyle(
                color: _badgeTextColor,
                fontWeight: FontWeight.w600,
                fontSize: width * 0.032,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // DONATION / CHARITY INFO TILE
  Widget _buildDonationInfoTile(Size size) {
    final width = size.width;

    return _titleTile(
      width: width,
      title: "معلومات الجمعية",
      child: Container(
        width: width * 0.1,
        height: width * 0.1,
        decoration: BoxDecoration(
          color: _iconBgColor,
          borderRadius: BorderRadius.circular(width * 0.06),
        ),
        child: Center(
          child: Image.asset("assets/images/fluent-mdl2_edit-contact (1).png"),
        ),
      ),
    );
  }

  // NOTIFICATIONS CARD
  Widget _buildNotificationsCard(Size size) {
    final width = size.width;

    return _sectionCard(
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width * 0.1,
                height: width * 0.1,
                decoration: BoxDecoration(
                  color: _iconBgColor,
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                child: Center(child: Image.asset("assets/images/bellch.png")),
              ),
              SizedBox(width: width * 0.025),
              Text(
                "الإشعارات",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _switchTile(
            width: width,
            title: "طلبات جديدة",
            subtitle: "إرسال إشعار عند تسجيل جمعية جديدة",
            value: newDonation,
            onChanged: (value) => setState(() => newDonation = value),
          ),
          _switchTile(
            width: width,
            title: "تحديثات الحسابات",
            subtitle: "إشعارات عند تعديل حالة الجمعيات",
            value: caseCompleted,
            onChanged: (value) => setState(() => caseCompleted = value),
          ),
          _switchTile(
            width: width,
            title: "التقارير اليومية",
            subtitle: "استلام تقرير يومي بنشاط النظام",
            value: campaignCompleted,
            onChanged: (value) => setState(() => campaignCompleted = value),
          ),
        ],
      ),
    );
  }

  // SECTION CARD
  Widget _sectionCard({required double width, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  // TITLE TILE
  Widget _titleTile({
    required double width,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.035,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          child,
          SizedBox(width: width * 0.025),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: width * 0.05)),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.charityInfoScreen);
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              size: width * 0.045,
              color: _arrowColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchTile({
    required double width,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.045,
                  ),
                ),
                SizedBox(height: width * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: width * 0.045, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.03),
          CustomSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  // ARROW TILE
  Widget arrowTile({required String title, required IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}
