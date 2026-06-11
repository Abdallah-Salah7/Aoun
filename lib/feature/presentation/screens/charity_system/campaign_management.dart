import 'package:aoun/feature/presentation/screens/widget/charity_campaign_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/models/camp_model.dart';
import '../../state_management/cubit/camp_cubit.dart';
import '../../state_management/cubit/camp_state.dart';
import 'app_drawer.dart';

class CampaignManagement extends StatefulWidget {
  const CampaignManagement({super.key});

  @override
  State<CampaignManagement> createState() => _CampaignManagementState();
}

class _CampaignManagementState extends State<CampaignManagement> {
  String selectedFilter = "الكل";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CampaignCubit>().fetchCampaigns(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 70, height: 70,
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.addCampaign),
            backgroundColor: const Color(0xff2F674D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: const Icon(Icons.add, size: 40, color: Colors.white),
          ),
        ),
        drawer: const AppDrawer(),
        appBar: AppBar(backgroundColor: const Color(0xff2F674D), toolbarHeight: 0),
        backgroundColor: const Color(0xffC7CDCD),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18, top: 18, bottom: 5),
                child: Row(
                  children: [
                    buildFilterButton("الكل"),
                    const SizedBox(width: 15),
                    buildFilterButton("مكتملة"),
                  ],
                ),
              ),

              BlocBuilder<CampaignCubit, CampaignState>(
                builder: (context, state) {
                  if (state is CampaignLoading) {
                    return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
                  }

                  if (state is CampaignLoaded) {
                    final filteredList = state.campaigns.where((c) {
                      if (selectedFilter == "مكتملة") return c.isCompleted;
                      return true;
                    }).toList();

                    return Column(
                      children: [
                        _buildStatisticsSection(state.stats),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return CharityCampaignItem(campaign: filteredList[index]);
                          },
                        ),
                      ],
                    );
                  }
                  if (state is CampaignError) {
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("خطأ: ${state.message}"),
                    ));
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2F674D),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      height: 148,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Row(
          children: [
            Builder(builder: (context) => InkWell(onTap: () => Scaffold.of(context).openDrawer(), child: Image.asset(ImageAssets.charityIcon))),
            const SizedBox(width: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("إدارة الحملات", style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                Text("لوحة التحكم", style: GoogleFonts.manrope(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection(StatsModel stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 6))]),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            child: Row(
              children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xffE3F0EA), borderRadius: BorderRadius.circular(45)), child: Image.asset(ImageAssets.totalDonation, height: 36, width: 36)),
                const SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("إجمالى التبرعات", style: GoogleFonts.manrope(fontSize: 19, fontWeight: FontWeight.w800, color: const Color(0xff6A6969))),
                  Text("${stats.totalDonations.toInt()} ج.م", style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.w700)),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              _buildSmallStat("عدد الحملات", "${stats.campaignsCount} حملة", ImageAssets.numCamps),
              const SizedBox(width: 15),
              _buildSmallStat("عدد المتبرعين", "${stats.donorsCount} متبرع", ImageAssets.numDonors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(String title, String value, String icon) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xffE3F0EA), borderRadius: BorderRadius.circular(45)), child: Image.asset(icon, height: 30, width: 30)),
          Text(title, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xff6A6969))),
          Text(value, style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () {
        // عند الضغط، نقوم بتغيير المتغير وعمل setState لإعادة بناء الصفحة
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
        decoration: BoxDecoration(color: isSelected ? const Color(0xff2F674D) : Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Text(title, style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }
}