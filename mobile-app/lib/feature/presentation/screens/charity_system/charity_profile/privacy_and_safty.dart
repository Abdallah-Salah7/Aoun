import 'package:flutter/material.dart';

class PrivacyAndSafetyScreen extends StatelessWidget {
  const PrivacyAndSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xffEEF2EE),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      /// Header
                      Row(
                        children: [
                          SizedBox(width: size.width * .07),
                          Text(
                            "الخصوصية والأمان",
                            style: TextStyle(
                              fontSize: isTablet ? 26 : 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff2E6B50),
                            ),
                          ),
                          const Spacer(),

                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * .01),

                      /// Logo
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Image.asset(
                          "assets/images/Group 82.png",
                          fit: BoxFit.contain,
                          width: isTablet ? 170 : 120,
                          height: isTablet ? 170 : 120,
                        ),
                      ),

                      SizedBox(height: size.height * .01),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "الخصوصية والأمان",
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Expanded(
                        child: const SingleChildScrollView(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              """
نحن نؤمن بأن الثقة أساس العمل الخيري، لذلك نحرص على حماية بيانات المستخدمين والحفاظ على خصوصيتهم أثناء استخدام التطبيق.
يتم استخدام بياناتك فقط لتسهيل عمليات التبرع وتحسين تجربتك داخل التطبيق، ولا تتم مشاركة أي معلومات شخصية مع أي جهة خارجية إلا عند الضرورة المرتبطة بخدمات الدفع أو تشغيل التطبيق بشكل آمن.
جميع عمليات الدفع تتم عبر أنظمة آمنة ومشفرة لضمان حماية معلوماتك المالية وبياناتك الشخصية بأعلى درجات الأمان.
كما أننا لا نقوم بالاحتفاظ ببيانات بطاقات الدفع الخاصة بالمستخدمين، ويتم التعامل معها من خلال مزودي خدمات دفع موثوقين ومعتمدين.
نسعى دائمًا لتوفير بيئة آمنة وموثوقة تتيح لك التبرع بكل راحة واطمئنان، مع الالتزام بأفضل معايير الحماية والأمان الرقمي.
وفي حال وجود أي استفسار أو ملاحظة بخصوص الخصوصية أو الأمان، يمكنك التواصل معنا بسهولة عبر وسائل الدعم المتاحة داخل التطبيق.
""",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                height: 2,
                                color: Color(0xff4B5563),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
