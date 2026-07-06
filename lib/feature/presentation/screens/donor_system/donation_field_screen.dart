import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../data/data_sources/donor_case_api_service.dart';
import '../../../domain/entities/donor_case_entity.dart';
import '../../state_management/cubit/donor_case_cubit.dart';
import '../../state_management/cubit/donor_case_state.dart';
import '../widget/donor_case_item.dart';

class DonationFieldScreen extends StatefulWidget {
  final int categoryId;

  const DonationFieldScreen({super.key, required this.categoryId});

  @override
  State<DonationFieldScreen> createState() => _DonationFieldScreenState();
}

class _DonationFieldScreenState extends State<DonationFieldScreen> {
  String selectedFilter = "الكل";
  String searchText = "";
  List<DonorCaseEntity> _applyFilter(List<DonorCaseEntity> cases) {
    bool isCompleted(DonorCaseEntity c) {
      return c.progress >= 1;
    }
    bool isUrgent(DonorCaseEntity c) {
      final completed = isCompleted(c);

      return c.isUrgent == true && !completed;
    }
    return cases.where((c) {

      final completed = isCompleted(c);
      final urgent = isUrgent(c);

      bool matchFilter;

      if (selectedFilter == "مكتملة") {
        matchFilter = completed;

      } else if (selectedFilter == "عاجلة جداً") {
        matchFilter = urgent;

      } else {
        matchFilter = !completed;
      }

      final matchSearch =
          c.title.toLowerCase().contains(searchText.toLowerCase()) ||
              c.description.toLowerCase().contains(searchText.toLowerCase());

      return matchFilter && matchSearch;
    }).toList();
  }

  final Map<int, String> categoryNames = {
    1: "الصحة",
    2: "التعليم",
    3: "الإغاثة",
    4: "كفالات",
    5: "مشاريع بناء",
    6: "التنمية",
    7: "ذوى الاحتياجات",
    8: "كفارات",
    9: "الغارمين",
    10: "الاطعام",
  };

  int totalDonors = 0;
  bool isLoadingDonors = true;

  Future<void> loadDonorsCount(List<DonorCaseEntity> cases) async {
    int total = 0;

    for (final c in cases) {
      print("Loading case id = ${c.id}");

      try {
        final response = await DonorCaseApiService().getCaseDetails(c.id);

        print("Success for case ${c.id}");
        print(response.data);

        final data = response.data;
        total += (data["donorsCount"] ?? 0) as int;

      } on DioException catch (e) {
        print("========== ERROR ==========");
        print("Case id = ${c.id}");
        print("Status = ${e.response?.statusCode}");
        print("Response = ${e.response?.data}");
        print("===========================");
      }
    }

    if (mounted) {
      setState(() {
        totalDonors = total;
        isLoadingDonors = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<DonorCaseCubit>().getCases(
      categoryName: categoryNames[widget.categoryId]!,
    );

    print("DonationFieldScreen opened");
    print("CategoryId = ${widget.categoryId}");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 189,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                // const Image(image: AssetImage(ImageAssets.icon)),
                // const SizedBox(width: 8),
                Center(
                  child: Text(
                    "مجال ${categoryNames[widget.categoryId]}" ?? "المجالات",
                    style: GoogleFonts.manrope(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        body: BlocBuilder<DonorCaseCubit, DonorCaseState>(
          builder: (context, state) {
            if (state is! DonorCaseLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final categoryCases = state.cases;
            if (isLoadingDonors) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                loadDonorsCount(categoryCases);
              });
            }
            final completedCasesCount = categoryCases
                .where((c) => c.progress >= 1)
                .length;

            final filteredCases = _applyFilter(categoryCases);
            return ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff2F7D57),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "نعمل على تقديم الدعم والمساعدة للمستحقين\n"
                                  "من خلال مبادرات وبرامج إنسانية متنوعة\n"
                                  "تلبي احتياجاتهم في مختلف المجالات،\n"
                                  "ومساهمتك تُحدث فرقًا حقيقيًا في حياتهم.",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.saira(
                                fontSize: 20,
                                color: Colors.white,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 25),

                            Row(
                              children: [
                                Expanded(
                                  child: _statCard(
                                    value: "$completedCasesCount",
                                    title: "حالات مكتملة",
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _statCard(
                                    value: isLoadingDonors ? "..." : "$totalDonors",
                                    title: "متبرع",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),



                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildFilterButton("الكل"),
                          buildFilterButton("عاجلة جداً"),
                          buildFilterButton("مكتملة"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredCases.length,
                      itemBuilder: (context, index) {
                        final c = filteredCases[index];

                        return DonorCaseItem(
                          donorCaseEntity: c,
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F674D) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
  Widget _statCard({
    required String value,
    required String title,
  }) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xffE0FBEE),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xff386E5C),
            ),
          ),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 18,
              color: const Color(0xff386E5C),
            ),
          ),
        ],
      ),
    );
  }
}
