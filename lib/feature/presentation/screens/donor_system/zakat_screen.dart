import 'package:flutter/material.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  int expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final items = [
      {"title": "الفقراء", "content": "هم الذين لا يجدون كفايتهم من المال."},
      {"title": "المساكين", "content": "من يملكون مالًا لا يكفيهم."},
      {"title": "العاملين عليها", "content": "المسؤولون عن جمع الزكاة."},
      {"title": "المؤلفة قلوبهم", "content": "من يُراد تأليف قلوبهم."},
      {"title": "في الرقاب", "content": "لتحرير الأسرى."},
      {"title": "الغارمين", "content": "المدينون غير القادرين."},
      {"title": "في سبيل الله", "content": "في نصرة الدين."},
      {"title": "ابن السبيل", "content": "المسافر المحتاج."},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),
        appBar: AppBar(
          backgroundColor: Color(0xffE5EBE9),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff283F34)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مصارف الزكاة",
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  color: const Color(0xFF255A41),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "فإن الله تعالى قد تولى في كتابه بيان مصارف الزكاة وحصرها في ثمانية أصناف، قال تعالى: إِنَّمَا الصَّدَقَاتُ لِلْفُقَرَاءِ وَالْمَسَاكين والعاملين عَلَيْها وَالْمُؤَلَّفَةِ قُلُوبُهُمْ وفي الرقاب والغارمين وفي سبيل الله وابن السبيل فريضةً مِّنَ اللهِ وَاللهُ عَلِيمٌ حَكِيمٌ [التوبة : 60]. وإليك بيان المقصود بكل من هذه الأصناف بصورة مختصرة",
                style: TextStyle(
                  fontSize: size.width * 0.043,
                  color: Color(0xff292B2A),
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: size.height * 0.02),

              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder:
                      (_, __) => Divider(color: Colors.grey[300], height: 1),
                  itemBuilder: (context, index) {
                    final isExpanded = expandedIndex == index;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.018,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                expandedIndex = isExpanded ? -1 : index;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  items[index]["title"]!,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: Color(0xff342821),
                                  ),
                                ),

                                Spacer(),

                                Icon(isExpanded ? Icons.remove : Icons.add),
                              ],
                            ),
                          ),
                        ),

                        AnimatedCrossFade(
                          duration: Duration(milliseconds: 250),
                          crossFadeState:
                              isExpanded
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                          firstChild: Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.015,
                            ),
                            child: Text(
                              items[index]["content"]!,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          secondChild: SizedBox(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
