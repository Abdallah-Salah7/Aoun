
import 'package:aoun/feature/presentation/screens/widget/charity_campaign_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../../state_management/cubit/campaign_cubit.dart';
import '../../state_management/cubit/campaign_state.dart';
import '../widget/charity_case_item.dart';
import 'app_drawer.dart';

class CampaignManagement extends StatefulWidget {
  const CampaignManagement({super.key});

  @override
  State<CampaignManagement> createState() => _CampaignManagementState();
}

class _CampaignManagementState extends State<CampaignManagement> {

  String selectedFilter = "الكل";
  String selectedCategory = "الكل";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                Routes.addCampaign,
              );

              if (result != null && result is CampaignEntity) {
                context.read<CampaignCubit>().addCampaign(result);
              }
            },
            backgroundColor: const Color(0xff2F674D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),

        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        backgroundColor: const Color(0xffC7CDCD),

        body: SingleChildScrollView(
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Color(0xff2F674D),
                  ),
                  height: 148,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 32,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, top: 18),
                          child: Builder(
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image(
                                  image: AssetImage(ImageAssets.charityIcon),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "إدارة الحملات",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "لوحة التحكم",
                                style: GoogleFonts.manrope(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      right: 18, left: 18, top: 18, bottom: 5),
                  child: Row(
                    children: [
                      buildFilterButton("الكل"),
                      SizedBox(width: 15,),
                      buildFilterButton("مكتملة"),
                    ],
                  ),
                ),

                const SizedBox(height: 18),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffE3F0EA),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Image(
                              image: AssetImage(ImageAssets.totalDonation),
                              height: 36,
                              width: 36,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "إجمالى التبرعات",
                              style: GoogleFonts.manrope(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xff6A6969),
                              ),
                            ),
                            Text(
                              "452,000 ج.م",
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE3F0EA),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.numCamps),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "عدد الحملات",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800, // SemiBold
                                    color: Color(0xff6A6969),
                                  ),
                                ),
                              ),
                              Text(
                                " 235 حملة\n",
                                style: GoogleFonts.manrope(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 28),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE3F0EA),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    image: AssetImage(ImageAssets.numDonors),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "عدد المتبرعين",
                                  style: GoogleFonts.manrope(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800, // SemiBold
                                    color: Color(0xff6A6969),
                                  ),
                                ),
                              ),
                              Text(
                                " 3250 متبرع \n",
                                style: GoogleFonts.manrope(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                BlocBuilder<CampaignCubit, CampaignState>(
                  builder: (context, state) {
                    if (state is CampaignLoaded) {
                      final filteredCampaign = state.campaigns.where((c) {

                        bool statusMatch;
                        if (selectedFilter == "الكل") {
                          statusMatch = true;
                        } else {
                          statusMatch = c.status == selectedFilter;
                        }

                        bool categoryMatch;
                        if (selectedCategory == "الكل") {
                          categoryMatch = true;
                        } else {
                          categoryMatch = c.category == selectedCategory;
                        }

                        return statusMatch && categoryMatch;

                      }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCampaign.length,
                        itemBuilder: (context, index) {
                          final campaignItem = filteredCampaign[index];

                          return CharityCampaignItem(
                            id: campaignItem.id,
                            image: campaignItem.image,
                            title: campaignItem.title,
                            description: campaignItem.description,
                            rateValue: campaignItem.rateValue,
                            collectedValue: campaignItem.collectedValue,
                            allValue: campaignItem.allValue,
                            status: campaignItem.status,
                            category: campaignItem.category,
                            startDate: campaignItem.startDate,
                            endDate: campaignItem.endDate,
                          );
                        },
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
}
