import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/resources/assets_manager.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

enum ServiceType { whatsapp, call }

class _CustomerServiceState extends State<CustomerService> {
  bool dontAskAgain = false;

  Future<void> openWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/111");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open WhatsApp');
    }
  }

  Future<void> makePhoneCall() async {
    await FlutterPhoneDirectCaller.callNumber("111");

  }

  Future<void> openTruecaller() async {
    final Uri truecallerUrl = Uri.parse("truecaller://");
    final Uri playStoreUrl = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.truecaller",
    );

    if (await canLaunchUrl(truecallerUrl)) {
      await launchUrl(truecallerUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "خدمة العملاء",
                  style: GoogleFonts.saira(
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                    color: const Color(0xff255A41),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 58.0,
                  horizontal: 8,
                ),
                child: Text(
                  "يمكنك التواصل معنا عبر خدمة الواتس آب، أو\nالتواصل بنا عبر خدمة الرد الآلي لتحصل على الرد\nالمناسب لكل استفساراتك وتقديم شكواك.",
                  style: GoogleFonts.saira(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: const Color(0xff342821),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                child: Column(
                  children: [
                    serviceItem(
                      title: "خدمة العملاء",
                      subtitle: "نسعد بمساعدتك عبر الواتساب",
                      assetImage: ImageAssets.whatsApp,
                      onTap: () {
                        if (!dontAskAgain) {
                          showServiceDialog(
                            context: context,
                            type: ServiceType.whatsapp,
                            onWhatsApp: openWhatsApp,
                            onPhone: makePhoneCall,
                            onTruecaller: () {},
                          );
                        } else {
                          openWhatsApp();
                        }
                      },
                    ),
                    serviceItem(
                      title: "اتصل بنا",
                      subtitle: "تحدث مع خدمة العملاء لدينا",
                      assetImage: ImageAssets.phone,
                      onTap: () {
                        if (!dontAskAgain) {
                          showServiceDialog(
                            context: context,
                            type: ServiceType.call,
                            onWhatsApp: openWhatsApp,
                            onPhone: makePhoneCall,
                            onTruecaller: openTruecaller,
                          );
                        } else {
                          makePhoneCall();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceItem({
    required String title,
    required String subtitle,
    required String assetImage,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 26),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffE5EBE9),
                borderRadius: BorderRadius.circular(45),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(assetImage, height: 28, width: 28),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.saira(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: const Color(0xff342821),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.saira(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xff342821),
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            const Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }

  void showServiceDialog({
    required BuildContext context,
    required ServiceType type,
    required VoidCallback onWhatsApp,
    required VoidCallback onPhone,
    required VoidCallback onTruecaller,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        "فتح بواسطة",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(
                              color: Color(0xff8D918F),
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (type == ServiceType.whatsapp)
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              onWhatsApp();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageAssets.whatsApp,
                                  width: 52,
                                  height: 52,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "واتساب",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        if (type == ServiceType.call)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                onTruecaller();
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImageAssets.truecaller,
                                    width: 34,
                                    height: 34,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "Truecaller",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (type == ServiceType.call)
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              onPhone();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImageAssets.phone,
                                    width: 52,
                                    height: 52,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "الهاتف",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "لا تسأل مرة أخرى",
                        style: TextStyle(fontSize: 18),
                      ),
                      Checkbox(
                        value: dontAskAgain,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color(0xff2C5240);
                          }
                          return Colors.white;
                        }),
                        onChanged: (v) {
                          setState(() {
                            dontAskAgain = v!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
