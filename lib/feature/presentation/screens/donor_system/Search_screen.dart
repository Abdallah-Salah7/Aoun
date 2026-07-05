import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/donor_system/case_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/data_sources/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> searchResults = [];
  bool isLoading = false;

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

  Future<void> searchCases(String keyword) async {
    if (keyword.trim().isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiServices.searchCases(keyword: keyword);

      setState(() {
        searchResults = response.data["data"] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Search
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 45,
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
                            controller: searchController,
                            onChanged: searchCases,
                            decoration: const InputDecoration(
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

                  /// Loading
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  /// Results
                  else if (searchResults.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final item = searchResults[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        CaseDetailsScreen(caseId: item["id"]),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "https://aounplatform.runasp.net${item["imageUrl"]}",
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) => const Icon(
                                            Icons.image_not_supported,
                                            size: 80,
                                          ),
                                    ),
                                  ),
                          
                                  const SizedBox(width: 12),
                          
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["title"],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                          
                                        const SizedBox(height: 6),
                          
                                        Text(
                                          item["description"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                          
                                        const SizedBox(height: 8),
                          
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                item["categoryName"],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                          
                                            const Spacer(),
                          
                                            Text(
                                              "${item["requiredAmount"]} ج.م",
                                              style: const TextStyle(
                                                color: Color(0xff2F674D),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  /// No Results
                  else if (searchController.text.isNotEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("لا توجد نتائج"),
                      ),
                    )
                  /// Default Screen
                  else ...[
                    const Text(
                      "أكثر المواضيع بحثاً",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
                    const SizedBox(height: 20),
                    const Divider(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
          boxShadow: const [
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
