import 'package:aoun/feature/data/data_sources/favorite_api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';

class SavedCases extends StatefulWidget {
  const SavedCases({super.key});

  @override
  State<SavedCases> createState() => _SavedCasesState();
}

class _SavedCasesState extends State<SavedCases> {
  late Future<List<dynamic>> favoritesFuture;

  Future<List<dynamic>> loadFavorites() async {
    final service = FavoriteApiService();

    final cases = await service.getFavoriteCases();
    final campaigns = await service.getFavoriteCampaigns();

    return [
      ...cases.map((e) => {...e, "type": "case"}),
      ...campaigns.map((e) => {...e, "type": "campaign"}),
    ];
  }

  @override
  void initState() {
    super.initState();
    favoritesFuture = loadFavorites();
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      favoritesFuture = loadFavorites();
    });
  }

  String buildImageUrl(String image) {
    if (image.isEmpty) return "";

    if (image.startsWith("http")) return image;

    if (image.startsWith("/")) {
      return "https://aounplatform.runasp.net$image";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "العناصر المحفوظة",
            style: GoogleFonts.saira(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: const Color(0xff255A41),
            ),
          ),
        ),

        body: FutureBuilder<List<dynamic>>(
          future: favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "حدث خطأ أثناء تحميل المفضلة",
                  style: GoogleFonts.saira(),
                ),
              );
            }

            final items = snapshot.data ?? [];

            if (items.isEmpty) {
              return Center(
                child: Text(
                  "لا توجد عناصر محفوظة",
                  style: GoogleFonts.saira(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                final String type = item["type"] ?? "";
                final int id = item["id"];

                final String title = item["title"] ?? "";
                final String description = item["description"] ?? "";

                final String imageUrl = buildImageUrl(item["image"] ?? "");

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [

                          /// IMAGE
                          ClipOval(
                            child: imageUrl.isEmpty
                                ? Image.asset(
                              ImageAssets.caseRec,
                              height: 77,
                              width: 77,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              imageUrl,
                              height: 77,
                              width: 77,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Image.asset(
                                  ImageAssets.caseRec,
                                  height: 77,
                                  width: 77,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// TEXT (FIXED OVERFLOW)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.saira(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff3B3D3C),
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.saira(
                                    fontSize: 16,
                                    color: const Color(0xff5A5B5A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),

                          /// REMOVE BUTTON
                          GestureDetector(
                            onTap: () async {
                              try {
                                if (type == "case") {
                                  await FavoriteApiService()
                                      .removeCaseFromFavorites(id);
                                } else {
                                  await FavoriteApiService()
                                      .removeCampaignFromFavorites(id);
                                }

                                await _refreshFavorites();
                              } catch (e) {
                                debugPrint("❌ delete error: $e");
                              }
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff2F674D),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.bookmark,
                                color: Color(0xff2F674D),
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 1,
                      color: const Color(0xff2E6B4F).withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}