import 'package:flutter/material.dart';
import 'package:aoun/feature/presentation/screens/donor_system/general_fatwa_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/gold_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/money_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/plant_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/silver_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/stocks_page.dart';
import 'package:aoun/feature/presentation/screens/donor_system/zakat_fiter_page.dart';

class FatawsOnZakat extends StatelessWidget {
  const FatawsOnZakat({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _Item("فتاوى عامة", "assets/images/Book.png", const GeneralFatwaPage()),
      _Item("المال", "assets/images/Money.png", const MoneyPage()),
      _Item("الذهب", "assets/images/Treasure.png", const GoldPage()),
      _Item("الفضة", "assets/images/Silver.png", const SilverPage()),
      _Item("الزرع", "assets/images/Plant.png", const PlantPage()),
      _Item("زكاة الفطر", "assets/images/Salary.png", const ZakatFiterPage()),
      _Item(
        "الأسهم",
        "assets/images/grommet-icons_directions.png",
        const StocksPage(),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "فتاوى الزكاة",
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
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    offset: Offset(0, 3),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: items.length,
                separatorBuilder:
                    (_, __) =>
                        const Divider(height: 1, color: Color(0xffE0E0E0)),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.page),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xffE5EBE9),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              item.img,
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xff43332B),
                          ),
                        ],
                      ),
                    ),
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

class _Item {
  final String title;
  final String img;
  final Widget page;

  _Item(this.title, this.img, this.page);
}
