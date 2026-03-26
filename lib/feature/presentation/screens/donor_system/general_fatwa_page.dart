import 'package:aoun/feature/presentation/screens/donor_system/fatwa_details1.dart';
import 'package:flutter/material.dart';

class GeneralFatwaPage extends StatelessWidget {
  const GeneralFatwaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fatwas = [
      {
        "title": "دفع الزكاة للفقير المديون الذى عنده مصدر دخل",
        "page": const FatwaDetails1(),
      },
      {"title": "كيف يتصرف الفقير بمال الزكاة", "page": const FatwaDetails1()},
      {
        "title": "دفع الزكاة للغارم مع الستر عليه",
        "page": const FatwaDetails1(),
      },
      {
        "title": "دفع الزكاة للفقير المديون الذى عنده مصدر دخل",
        "page": const FatwaDetails1(),
      },
      {
        "title": "دفع الزكاة لأسر محتاجة لا ينفق عليها عائلها",
        "page": const FatwaDetails1(),
      },
      {
        "title": "حكم دفع الزكاة كلها للزوج الغارم",
        "page": const FatwaDetails1(),
      },
      {
        "title": "حكم دفع الزكاة للولد الغارم العاجز عن السداد",
        "page": const FatwaDetails1(),
      },
      {
        "title": "دفع الزكاة لأسر محتاجة لا ينفق عليها عائلها",
        "page": const FatwaDetails1(),
      },
      {
        "title": "حكم دفع الزكاة كلها للزوج الغارم",
        "page": const FatwaDetails1(),
      },
      {
        "title": "دفع الزكاة لحملات إغاثة اللاجئين",
        "page": const FatwaDetails1(),
      },
    ];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
            child: Container(
              constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    offset: Offset(0, 3),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: ListView.separated(
                itemCount: fatwas.length,
                separatorBuilder:
                    (_, __) =>
                        const Divider(height: 1, color: Color(0xffC4C4C4)),
                itemBuilder: (context, index) {
                  final item = fatwas[index];
                  final Widget page = item["page"] as Widget;
                  final String title = item["title"] ?? "";

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.015,
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize:
                            screenWidth * 0.045, // scales with screen width
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: const Color(0xff43332B),
                      size: screenWidth * 0.06,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => page),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
