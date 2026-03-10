import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/header_widget.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/progress_bar.dart';

class CharityFiles extends StatefulWidget {
  const CharityFiles({super.key});

  @override
  State<CharityFiles> createState() => _CharityFilesState();
}

class _CharityFilesState extends State<CharityFiles> {
  bool remember = false;

  final List<Map<String, String>> documents = [
    {"label": "شهادة تسجيل الجمعية", "image": "assets/images/certificate.png"},
    {"label": "البطاقة الضريبية", "image": "assets/images/credit-card.png"},
    {
      "label": "إثبات حساب بنكى باسم الجمعية",
      "image": "assets/images/bank.png",
    },
    {"label": "بطاقة الرقم القومى للمسئول", "image": "assets/images/id.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final cardWidth = width > 600 ? 520.0 : width * .92;

    double scale(double value) => value * (width / 390);

    return Scaffold(
      backgroundColor: const Color(0xffD9DDDA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: cardWidth,
              child: Column(
                children: [
                  SizedBox(height: height * .04),

                  /// Header
                  Header(
                    width: width,
                    title: 'رفع المستندات الرسمية',
                    subTitle:
                        "سيتم استخدام هذه المستندات للتحقق من حساب الجمعية",
                  ),

                  SizedBox(height: height * .03),

                  /// Progress Bar
                  const ProgressBar(
                    active1: true,
                    active2: true,
                    active3: true,
                  ),

                  SizedBox(height: height * .04),

                  /// Title
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "مستندات التوثيق",
                      style: TextStyle(
                        fontSize: scale(26),
                        color: PrimaryColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: height * .02),

                  /// Documents Card
                  Container(
                    padding: EdgeInsets.all(scale(18)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(scale(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ...List.generate(documents.length, (index) {
                          final doc = documents[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: height * .02),
                            child: CustomFormField(
                              label: doc["label"]!,
                              hint: "اضغط لرفع الملف",
                              downloadIcon: true,
                              imagePath: doc["image"]!,
                            ),
                          );
                        }),

                        Text(
                          "الصيغ المسموح بها : PDF - JPG - PNG",
                          style: TextStyle(
                            color: const Color(0xff7E7B7B),
                            fontSize: scale(16),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * .04),

                  /// Agreement Box
                  Container(
                    padding: EdgeInsets.all(scale(12)),
                    decoration: BoxDecoration(
                      color: const Color(0xffCEBF3D).withOpacity(.15),
                      borderRadius: BorderRadius.circular(scale(10)),
                      border: Border.all(color: const Color(0xffCEBF3D)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "أقر بأن جميع البيانات والمستندات المقدمة صحيحة ودقيقة ، وأتحمل المسئولية الكاملة عن أى معلومات خاطئة",
                            style: TextStyle(
                              fontSize: scale(16),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff4B4B4B),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: remember,
                            activeColor: PrimaryColors.primaryColor,
                            onChanged: (v) {
                              setState(() {
                                remember = v!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * .04),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * .065,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => DialogWidget(
                                      markColor: PrimaryColors.primaryColor,
                                      markColorBacground: Color(0xffA7C0B5),
                                      accounState: 'تم الإرسال بنجاح!',
                                      accounStateParagraph: Text(
                                        "تم إرسال البيانات بنجاح ، سيتم مراجعة الحساب والتحقق من المستندات المرفقة قبل التفعيل",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: scale(17),
                                          color: const Color(0xff7E7B7B),
                                        ),
                                      ),
                                      accountStateButton: 'حسناً',
                                      icon: Icons.check,
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          Routes.accountStateScreen,
                                        );
                                      },
                                    ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PrimaryColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(scale(10)),
                              ),
                            ),
                            child: Text(
                              "إرسال للمراجعة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: scale(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * .04),

                      Expanded(
                        child: SizedBox(
                          height: height * .065,
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
                                color: const Color(0xff2F2E2E),
                                fontSize: scale(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * .05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
