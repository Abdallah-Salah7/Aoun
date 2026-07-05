import 'package:aoun/feature/presentation/screens/widget/campaign_item.dart';
import 'package:aoun/feature/presentation/screens/widget/case_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../state_management/cubit/camp_cubit.dart';
import '../../state_management/cubit/camp_state.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../../state_management/cubit/case_state.dart'
    show CaseLoaded, CaseState;

class CharityProfileScreen extends StatefulWidget {
  const CharityProfileScreen({super.key});

  @override
  State<CharityProfileScreen> createState() => _CharityProfileScreenState();
}

class _CharityProfileScreenState extends State<CharityProfileScreen> {

  String selectedFilter = "الحالات";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "غيث للتنمية المجتمعية",
            style: GoogleFonts.manrope(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C5240),
            ),
          ),
          titleSpacing: 0,
          centerTitle: true,
        ),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Image(
                        image: AssetImage(ImageAssets.ghaith),
                        fit: BoxFit.cover,
                        width: 105,
                        height: 105,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "غيث للتنمية المجتمعية",
                      style: GoogleFonts.manrope(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2C5240),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff276D4C),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 172,
                          height: 69,
                          margin: EdgeInsets.only(right: 25, left: 6, top: 27),
                          child: Center(
                            child: Text(
                              "1500+\nمستفيد",
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff276D4C),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 172,
                          height: 69,
                          margin: EdgeInsets.only(left: 25, right: 6, top: 27),
                          child: Center(
                            child: Text(
                              "1000+\nمتبرع",
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " عن الجمعية",
                          style: GoogleFonts.manrope(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "جمعية خيرية متخصصة فى تقديم الرعاية الصحية والدعم\n الطبى للأطفال المحتاجين.\n نعمل منذ 2015 على تحسين حياة الأطفال\n وعائلاتهم من خلال توفير العلاج والرعاية اللازمة ",
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        Routes.emergencyFundScreen,

                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 35.0,
                        horizontal: 7,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xff1A593B),
                          borderRadius:
                          BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(width: 12),

                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "خزنة  الطوارئ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "دعم فوري للحالات العاجلة",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [

                                Text(
                                  "عرض التفاصيل",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 22),

                                Icon(
                                  Icons.north_west,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD4E1DB),
                        border: Border.all(
                          color: const Color(0xff2F674D),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: buildFilterButton("الحالات")),
                          Expanded(child: buildFilterButton("الحملات")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  selectedFilter == "الحالات"
                      ? BlocBuilder<CaseCubit, CaseState>(
                        builder: (context, state) {
                          if (state is CaseLoaded) {
                            final cases =
                                state.cases.where((c) {
                                  return c.status != "مكتملة";
                                }).toList();

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cases.length,
                              itemBuilder: (context, index) {
                                final caseItem = cases[index];

                                return CaseItem(
                                  caseEntity: caseItem,
                                );
                              },
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                      : BlocBuilder<CampaignCubit, CampaignState>(
                    builder: (context, state) {
                      if (state is CampaignLoaded) {
                        final campaigns = state.campaigns;

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: campaigns.length,
                              itemBuilder: (context, index) {
                                final campaign = campaigns[index];


                                return CampaignItem(
                                  campEntity: campaign,
                                );              },
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final bool isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F674D) : Colors.white,
          borderRadius:
              title == "الحالات"
                  ? const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                  : const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xff2F674D),
          ),
        ),
      ),
    );
  }
}
