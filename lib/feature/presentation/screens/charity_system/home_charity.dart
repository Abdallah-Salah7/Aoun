import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../data/models/charity_dashboard_model.dart';
import '../../state_management/cubit/dashboard_cubit.dart';
import '../../state_management/cubit/dashboard_state.dart';
import '../widget/donation_chart.dart';
import '../widget/weekly_chart.dart';
import 'app_drawer.dart';

class HomeCharity extends StatefulWidget {
  const HomeCharity({super.key});

  @override
  State<HomeCharity> createState() => _HomeCharityState();

}


class _HomeCharityState extends State<HomeCharity> {

  String charityName = "اسم الجمعية";

  @override
  void initState() {
    super.initState();

    loadCharityName();

    Future.microtask(() {
      context.read<DashboardCubit>().getDashboardStats();
    });
  }

  Future<void> loadCharityName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      charityName =
          prefs.getString("charityName") ??
              "اسم الجمعية";
    });
  }

  String formatTimeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inSeconds < 60) {
      return "منذ لحظات";
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1
          ? "منذ دقيقة"
          : "منذ $minutes دقيقة";
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1
          ? "منذ ساعة"
          : "منذ $hours ساعة";
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return days == 1
          ? "منذ يوم"
          : "منذ $days يوم";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: const Color(0xffC7CDCD),

        body:
        BlocBuilder<DashboardCubit, DashboardState>(
          buildWhen: (prev, curr) => curr is! DashboardLoading,
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is DashboardError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is DashboardSuccess) {
              final data = state.dashboard;

              return
                CustomScrollView(
                  slivers: [

                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xff2F674D),
                      expandedHeight: 120,
                      toolbarHeight: 120,
                      elevation: 0,
                      clipBehavior: Clip.hardEdge,

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),

                      flexibleSpace: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                          ),

                          child: Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              /// menu icon
                              Builder(
                                builder: (context) {
                                  return InkWell(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: Image.asset(
                                      ImageAssets.charityIcon,
                                      width: 32,
                                      height: 32,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(width: 22),


                              /// title
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    charityName,
                                    style: GoogleFonts.manrope(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "لوحة التحكم",
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              /// notification
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset(
                                    ImageAssets.bell,
                                    width: 30,
                                    height: 30,
                                    color: Colors.white,
                                  ),

                                  Positioned(
                                    left: 1,
                                    top: -1,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff6DDA6F),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),




                            ],
                          ),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "الإحصائيات",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                              const Color(0xffE3F0EA),
                                              borderRadius:
                                              BorderRadius.circular(
                                                45,
                                              ),
                                            ),
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Image(
                                              image: AssetImage(
                                                ImageAssets
                                                    .totalDonation,
                                              ),
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            "إجمالى التبرعات",
                                            style:
                                            GoogleFonts.manrope(
                                              fontSize: 19,
                                              fontWeight:
                                              FontWeight.w800,
                                              color: const Color(
                                                0xff6A6969,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "${data.totalDonations} ج.م",
                                          style:
                                          GoogleFonts.manrope(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 28),

                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                              const Color(0xffE3F0EA),
                                              borderRadius:
                                              BorderRadius.circular(
                                                45,
                                              ),
                                            ),
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Image(
                                              image: AssetImage(
                                                ImageAssets.numDonors,
                                              ),
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            "عدد المتبرعين",
                                            style:
                                            GoogleFonts.manrope(
                                              fontSize: 19,
                                              fontWeight:
                                              FontWeight.w800,
                                              color: const Color(
                                                0xff6A6969,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "${data.totalDonors} متبرع",
                                          style:
                                          GoogleFonts.manrope(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 22),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                              const Color(0xffE3F0EA),
                                              borderRadius:
                                              BorderRadius.circular(
                                                45,
                                              ),
                                            ),
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Image(
                                              image: AssetImage(
                                                ImageAssets.numCases,
                                              ),
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            "عدد الحالات",
                                            style:
                                            GoogleFonts.manrope(
                                              fontSize: 19,
                                              fontWeight:
                                              FontWeight.w800,
                                              color: const Color(
                                                0xff6A6969,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "${data.totalCases} حالة",
                                          style:
                                          GoogleFonts.manrope(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 28),

                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                              const Color(0xffE3F0EA),
                                              borderRadius:
                                              BorderRadius.circular(
                                                45,
                                              ),
                                            ),
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Image(
                                              image: AssetImage(
                                                ImageAssets.numCamps,
                                              ),
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            "عدد الحملات",
                                            style:
                                            GoogleFonts.manrope(
                                              fontSize: 19,
                                              fontWeight:
                                              FontWeight.w800,
                                              color: const Color(
                                                0xff6A6969,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "${data.totalCampaigns} حملة",
                                          style:
                                          GoogleFonts.manrope(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                top: 18,
                                bottom: 18,
                              ),
                              child: Text(
                                "التحليلات",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            WeeklyChart(
                              title: "التبرعات خلال الفترة",

                              weeklyGrowth:
                              data.weeklyGrowth,

                              monthlyGrowth:
                              data.monthlyGrowth,
                            ),

                            const SizedBox(height: 18),

                            DonationChart(

            categories: data.categoryDistribution,
            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 35.0,
                                horizontal: 7,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5631),
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
                                              "صندوق الطوارئ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "الرصيد المتاح: ${data.emergencyFundBalance} ج.م",
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

                                    const Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.north_west,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "عرض التفاصيل",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    "النشاط الأخير",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  const Spacer(),

                                  InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      "عرض المزيد",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff248457),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),

                              child: ListView.separated(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount:
                                data.recentDonationStatistic.length,
                                separatorBuilder:
                                    (context, index) =>
                                const Divider(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,

                                    leading: CircleAvatar(
                                      backgroundColor: const Color(0xffC7CDCD),
                                      child: Text(
                                        data.recentDonationStatistic[index]
                                            .donorName
                                            .trim()
                                            .isNotEmpty
                                            ? data.recentDonationStatistic[index]
                                            .donorName
                                            .trim()[0]
                                            : "?",
                                        style: const TextStyle(
                                          color: Color(0xFF1E5631),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),

                                    title: Text(
                                      data.recentDonationStatistic[index].donorName,
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),

                                    subtitle: Text(
                                      data.recentDonationStatistic[index].targetName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),

                                    trailing:  Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${data.recentDonationStatistic[index].amount} ج.م",
                                          style: TextStyle(
                                            color:
                                            Color(0xff255A41),
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          formatTimeAgo(
                                            data.recentDonationStatistic[index].date,
                                          ),
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            }

            return const SizedBox();
          },
        )
      ),
    );
  }
}