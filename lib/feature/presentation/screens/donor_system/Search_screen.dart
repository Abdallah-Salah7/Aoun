import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final List<String> popularTopics = [
    "الأطراف الصناعية",
    "دعم غزة",
    "قوافل السودان",
  ];

  final List<Map<String, String>> categories = [
    {"title": "التعليم", "image": "assets/images/Classroom.png"},
    {"title": "مشاريع بناء", "image": "assets/images/BrickWall.png"},
    {"title": "كفالات", "image": "assets/images/Social care.png"},
    {"title": "الصحة", "image": "assets/images/Health check.png"},
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffE5EBE9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffDBE4E1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 2),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "البحث",
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xff2F674D),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.homePage);
                          },
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(color: Color(0xff2F674D)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "أكثر المواضيع بحثاً",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        popularTopics
                            .map((topic) => _buildChip(topic))
                            .toList(),
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),

                  const Text(
                    "مجالات التبرع",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 15),

                  GridView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.55,
                        ),
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return _buildCategory(
                        category["image"]!,
                        category["title"]!,
                      );
                    },
                  ),

                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),

                  const Text(
                    "مبادرات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: screenWidth * 0.45,
                    height: 70,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff99CFB6),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "هدية",
                          style: TextStyle(
                            color: Color(0xff0B432A),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "assets/images/basil_present-outline.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///  Chip
Widget _buildChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xffCEE5DA),
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(blurRadius: 2, offset: Offset(0, 2), color: Colors.grey),
      ],
    ),
    child: Text(text),
  );
}

///  Category
Widget _buildCategory(String imgPath, String title) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 55,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff83B09B),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(blurRadius: 2, offset: Offset(0, 2), color: Colors.grey),
          ],
        ),
        child: Image.asset(imgPath, fit: BoxFit.contain),
      ),
      const SizedBox(height: 5),
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    ],
  );
}
