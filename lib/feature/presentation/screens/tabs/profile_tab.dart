import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);
    }
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _image = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "الملف الشخصى",
                      style: GoogleFonts.saira(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xff255A41),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffDDE5E2),
                            ),
                            width: 120,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  _image != null ? FileImage(_image!) : null,
                              child:
                                  _image == null
                                      ? const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey,
                                      )
                                      : null,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 22,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "  ندى عدلى مراد",
                      style: GoogleFonts.saira(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff255A41),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffD4E1DB),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 172,
                              height: 69,
                              margin: EdgeInsets.only(
                                left: 14,
                                right: 6,
                                top: 22,
                              ),
                              child: Center(
                                child: Text(
                                  "    12\nمرة تبرع",
                                  style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff2C5240),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffD4E1DB),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 172,
                              height: 69,
                              margin: EdgeInsets.only(
                                right: 14,
                                left: 6,
                                top: 22,
                              ),
                              child: Center(
                                child: Text(
                                  " 5,800 ج.م\nإجمالى التبرعات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff2C5240),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Directionality(
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
                        margin: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 12,
                        ),

                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.donationRecord,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
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
                                        image: AssetImage(ImageAssets.history),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "سجل التبرعات",
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
                                Navigator.pushNamed(context, Routes.savedCases);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
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
                                        image: AssetImage(ImageAssets.fav),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "الحالات المحفوظة",
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
                                Navigator.pushNamed(context, Routes.settings);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
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
                                        image: AssetImage(ImageAssets.setting),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "الاعدادات",
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
                                Navigator.pushNamed(
                                  context,
                                  Routes.privacyAndSecurity,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
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
                                        image: AssetImage(ImageAssets.security),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "الخصوصية والأمان",
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
                          ],
                        ),
                      ),
                    ),
                    Directionality(
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
                        margin: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 12,
                        ),

                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.customerService,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
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
                                        image: AssetImage(ImageAssets.service),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "خدمة العملاء",
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
                                Navigator.pushNamed(
                                  context,
                                  Routes.donorLoginScreen,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
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
                                        image: AssetImage(ImageAssets.out),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      " تسجيل الخروج",
                                      style: GoogleFonts.saira(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Color(0xffAB1818),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
