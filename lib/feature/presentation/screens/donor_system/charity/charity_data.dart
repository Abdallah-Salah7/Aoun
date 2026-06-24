import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/header_widget.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/progress_bar.dart';
import 'package:flutter/material.dart';

class CharityData extends StatelessWidget {
  CharityData({super.key});
  final TextEditingController charityNameController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double scale(double value) => value * (width / 390);

    final cardWidth = width > 600 ? 500.0 : width * 0.92;

    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: cardWidth,
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  Header(
                    width: width,
                    title: 'بيانات الجمعية الأساسية',
                    subTitle: 'من فضلك أدخل البيانات الرسمية للجمعية',
                  ),
                  SizedBox(height: height * 0.03),
                  const ProgressBar(
                    active1: true,
                    active2: true,
                    active3: false,
                  ),
                  SizedBox(height: height * 0.04),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "بيانات الجمعية",
                      style: TextStyle(
                        fontSize: scale(30),
                        color: PrimaryColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(scale(18)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(scale(20)),
                    ),
                    child: Column(
                      children: [
                        CustomFormField(
                          label: "اسم الجمعية",
                          hint: "أدخل اسم الجمعية",
                          controller: charityNameController,
                        ),
                        SizedBox(height: height * 0.02),
                        CustomFormField(
                          label: "رقم القيد/الترخيص",
                          hint: "أدخل رقم القيد",
                          controller: licenseController,
                        ),
                        SizedBox(height: height * 0.02),
                        CustomFormField(
                          label: "العنوان",
                          hint: "المحافظة . الشارع. الحى ......",
                          controller: addressController,
                        ),
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "نبذة عن الجمعية",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: scale(22),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: scale(6)),
                        TextField(
                          controller: descriptionController,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          maxLines: width > 600 ? 4 : 3,
                          style: TextStyle(fontSize: scale(14)),
                          decoration: InputDecoration(
                            hintText:
                                "اكتب نبذة مختصرة عن أهداف الجمعية وأنشطتها",
                            hintStyle: TextStyle(
                              color: const Color(0xffC4C4C4),
                              fontSize: scale(18),
                            ),
                            filled: true,
                            fillColor: const Color(0xffFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scale(8)),
                              borderSide: BorderSide(
                                color: Colors.grey.withAlpha(100),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scale(8)),
                              borderSide: BorderSide(
                                color: Colors.grey.withAlpha(100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: cardWidth * 0.4,
                          height: height * 0.06,
                          child: AuthButton(
                            text: "التالى",
                            onTap: () async {
                              try {
                                final response =
                                    await ApiServices.completeProfile(
                                      data: {
                                        "charityName":
                                            charityNameController.text,
                                        "licenseNumber": licenseController.text,
                                        "address": addressController.text,
                                        "description":
                                            descriptionController.text,
                                      },
                                    );

                                if (response.statusCode == 200) {
                                  // نجاح
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "تم حفظ بيانات الجمعية بنجاح",
                                      ),
                                    ),
                                  );

                                  // الانتقال للصفحة التالية
                                  Navigator.pushNamed(
                                    context,
                                    Routes.charityFilesScreen,
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: cardWidth * 0.4,
                          height: height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(scale(10)),
                              ),
                            ),
                            child: Text(
                              "السابق",
                              style: TextStyle(
                                fontSize: scale(20),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff2F2E2E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
