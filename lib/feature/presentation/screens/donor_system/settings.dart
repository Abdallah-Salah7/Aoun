import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "الإعدادات",
              style: GoogleFonts.saira(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: const Color(0xff255A41),
              ),
            ),
          ),
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 78,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 12),

                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.personalInformation,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 26,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE5EBE9),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.personInfo),
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "المعلومات الشخصية",
                                style: GoogleFonts.saira(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xff342821),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editPassword);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 26,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE5EBE9),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.changePass),
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "تغيير كلمة المرور ",
                                style: GoogleFonts.saira(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xff342821),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editEmail);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 26,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE5EBE9),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Image(
                                  image: AssetImage(ImageAssets.changeEmaill),
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "تغيير البريد الإلكترونى",
                                style: GoogleFonts.saira(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xff342821),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 26,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 38.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "إصدار التطبيق",
                                  style: GoogleFonts.saira(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xff342821),
                                  ),
                                ),
                                Text(
                                  "1.0",
                                  style: GoogleFonts.saira(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xff6A6969),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
