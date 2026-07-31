import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/authentication/logo_widget.dart';

class PrivacyAndSecurity extends StatelessWidget {
  const PrivacyAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon:  Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("الخصوصية والأمان",
            style: GoogleFonts.saira(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xff255A41)
            ),
          ),
        ),


        body:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: LogoWidget(),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Text("الخصوصية والأمان",
                style: GoogleFonts.saira(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Color(0xff342821)
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 36.0,left: 68),
                child: Text("نحرص على حماية بياناتك الشخصية ونلتزم بالحفاظ على خصوصيتك عند استخدام التطبيق.\nيتم استخدام بياناتك فقط لتنفيذ عمليات التبرع وتحسين تجربة الاستخدام، ولا يتم مشاركتها مع أي جهة خارجية إلا في حدود الضرورة مثل خدمات الدفع الإلكتروني.\nجميع عمليات الدفع داخل التطبيق تتم من خلال أنظمة آمنة ومشفرة لضمان حماية معلوماتك المالية.\nنحن لا نقوم بالاحتفاظ ببيانات بطاقات الدفع الخاصة بك، ويتم التعامل معها من خلال مزودي خدمات دفع موثوقين.\nيمكنك استخدام التطبيق بكل ثقة، حيث نلتزم بتطبيق أفضل معايير الأمان لحماية بياناتك.\nفي حال وجود أي استفسار بخصوص الخصوصية أو الأمان، يمكنك التواصل معنا عبر وسائل الدعم المتاحة داخل التطبيق.",
                style: GoogleFonts.saira(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54
                ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
