import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/feature/presentation/screens/charity_system/app_drawer.dart';
import 'package:aoun/feature/presentation/screens/widget/security_sction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharitySettings extends StatelessWidget {
  const CharitySettings({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              // HEADER
              Container(
                height: height * 0.1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: Color(0xff2F674D),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.bell,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                          Positioned(
                            left: 5,
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
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(size.width * 0.055),
                  child: Column(
                    children: [
                      // PROFILE CARD
                      _sectionCard(
                        child: Column(
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEAF2EF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/solar_settings-outline.png",
                                    ),
                                  ),
                                ),
                                Text(
                                  "إعدادات المسؤول",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),

                            CircleAvatar(
                              radius: size.width * 0.09,
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(
                                Icons.person,
                                size: size.width * 0.09,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: size.height * 0.015),

                            const Text(
                              "مدير النظام",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "admin@example.com",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: size.height * 0.015),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "مسؤول النظام",
                                style: TextStyle(
                                  color: Color(0xff067A57),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // DONATION SECTION
                      _titleTile(
                        title: "معلومات الجمعية",
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF2EF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/fluent-mdl2_edit-contact.png",
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // SETTINGS CARD
                      _sectionCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEAF2EF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/notification.png",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("الإشعارات",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            _switchTile(
                              title: "تبرعات جديدة",
                              subtitle: "إرسال إشعار عند تبرع جديد",
                              value: true,
                              onChanged: (_) {},
                            ),
                            _switchTile(
                              title: "اكتمال حالة",
                              subtitle: "إرسال إشعار عند اكتمال حالة",
                              value: false,
                              onChanged: (_) {},
                            ),
                            _switchTile(
                              title: "اكتمال حملة",
                              subtitle: "إشعارات عند اكتمال حملة",
                              value: true,
                              onChanged: (_) {},
                            ),
                            _switchTile(
                              title: "التقارير اليومية",
                              subtitle: "استلام تقرير يومي بنشاط النظام",
                              value: false,
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),
                      
                      // SECURITY CARD
                     SecuritySction(),
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

  // SECTION CARD
  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  // TITLE TILE
  Widget _titleTile({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          child,
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 15)),
          const Spacer(),

          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Color(0xff43332B),
          ),
        ],
      ),
    );
  }

  // SWITCH TILE
  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      splashRadius: 15,
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStatePropertyAll(Color(0xff2F674D)),

      trackColor: WidgetStateProperty.all(Color(0xff559376,)),
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    );
  }

  // ARROW TILE
  Widget _arrowTile({required String title, required IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}
