import 'package:aoun/feature/presentation/screens/donor_system/sendEmail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widget/call107.dart';
import '../widget/contact_card.dart';
import '../widget/openWebsite.dart';
import '../widget/send_email.dart';

class FundsZakat extends StatelessWidget {
  const FundsZakat({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff283F34),
              size: 30,
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 55.0),
                child: Text("التواصل مع دار الإفتاء المصرية",
                style: GoogleFonts.cairo(
                  color: Color(0xff065F46),
                  fontWeight: FontWeight.w700,
                  fontSize: 24
                ),),
              ),
            ),
            ContactCard(
              title: "اتصال مباشر",
              subtitle: "تواصل عبر الهاتف مع دار الإفتاء",
              image: ImageAssets.phoneIcon,
              onTap: call107,

            ),
            ContactCard(
              title: "زيارة الموقع الرسمي",
              subtitle: "تصفح الموقع الرسمي لدار الإفتاء",
              image: ImageAssets.emailIcon,
              onTap:openWebsite,
            ),
            ContactCard(
              title: "إرسال بريد إلكتروني",
              subtitle: "تواصل عبر البريد الإلكتروني",
              image: ImageAssets.langIcon,
              onTap: () {
                SendEmail.send(
                  email: "example@gmail.com",
                  subject: "طلب مساعدة",
                  body: "مرحبا، أريد التواصل بخصوص...",
                );
              },
            ),
            SizedBox(height: 63,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("يمكنك التواصل مع دار الإفتاء المصرية للحصول على \nالإرشادات الشرعية المتعلقة بالزكاة والصدقات والتبرعات.",
            textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                color: Color(0xff383939),
                fontWeight: FontWeight.w600,
                fontSize: 18
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
