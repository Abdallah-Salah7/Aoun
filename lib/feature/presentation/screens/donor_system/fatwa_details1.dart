import 'package:flutter/material.dart';

class FatwaDetails1 extends StatelessWidget {
  const FatwaDetails1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xffE5EBE9),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "فتاوى عامة",
            style: TextStyle(
              color: Color(0xff255A41),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.015,
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "دفع الزكاة للفقير المديون الذى عنده مصدر دخل",
                  style: TextStyle(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                const Divider(thickness: 1),

                SizedBox(height: size.height * 0.01),

                Text(
                  "الجواب",
                  style: TextStyle(
                    color: const Color(0xff267551),
                    fontSize: size.width * 0.05,
                  ),
                ),

                SizedBox(height: size.height * 0.015),

                Text(
                  "فإن كان خالك قادرًا على سداد دينه، ويستطيع بعمله و مصدر دخله الحصول على حاجته، وحاجة من تلزمه نفقته من مطعم وملبس، ومسكن، وغيرها مما لا بد منه بالمعروف، حسب ما يليق بحاله وحال من تلزمه نفقته من غير إسراف ولا تقتير، فإن الزكاة لا تدفع إليه. فإن لم يكن عنده ما يكفي لذلك جاز إعطاؤه من الزكاة، بل هو أولى بها من غيره؛ لأن الصدقة على ذي الرحم إثنتان صدقة وصلة - كما قال النبي صلى الله عليه وسلم، وصاحب الدين جعل الله تعالى له نصيبا من الزكاة، فقال سبحانه وتعالى: إِنَّمَا الصَّدَقَاتُ لِلْفُقَرَاءِ وَالْمَسَاكِينِ وَالْعَامِلِينَ عَلَيْهَا وَالْمُؤَلَّفَةِ قُلُوبُهُمْ وَفِي الرِّقَابِ وَالْغَارِمِينَ وَفِي سَبِيلِ اللَّهِ وَابْنِ السَّبِيلِ فَرِيضَةً مِنَ اللَّهِ وَاللَّهُ عَلِيمٌ حَكِيمٌ (التوبة : 60).",
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    height: 1.7,
                    color: const Color(0xff342821),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
