import 'package:aoun/feature/presentation/screens/widget/donate_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../state_management/cubit/dashboard_cubit.dart';
import '../../state_management/cubit/dashboard_state.dart';
import '../widget/weekly_chart.dart';
import 'app_drawer.dart';

class CharityReports extends StatefulWidget {
  const CharityReports({super.key});

  @override
  State<CharityReports> createState() => _CharityReportsState();
}

class _CharityReportsState extends State<CharityReports> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DashboardCubit>().getDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        backgroundColor: const Color(0xFFD9DDDA),

        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }

            if (state is DashboardSuccess) {
              final dashboard = state.dashboard;

              return ListView(
                padding: EdgeInsets.zero,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// HEADER
                      Container(
                        height: height * 0.1,

                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),

                          color: Color(0xff2F674D),
                        ),

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.08,
                            vertical: height * 0.01,
                          ),

                          child: Row(
                            children: [
                              Builder(
                                builder: (context) {
                                  return InkWell(
                                    onTap:
                                        () => Scaffold.of(context).openDrawer(),

                                    child: Image(
                                      image: AssetImage(
                                        ImageAssets.charityIcon,
                                      ),

                                      width: width * 0.1,
                                    ),
                                  );
                                },
                              ),

                              SizedBox(width: width * 0.05),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "التقارير والإحصائيات",

                                    style: GoogleFonts.manrope(
                                      fontSize: width * 0.05,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    "لوحة التحكم",

                                    style: GoogleFonts.manrope(
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(width * 0.04),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /// today donations
                            infoCard(
                              width,
                              height,

                              title: "إجمالى التبرعات اليوم",

                              value: "${dashboard.todayDonations} ج.م",
                            ),

                            SizedBox(height: height * 0.03),

                            /// emergency balance
                            infoCard(
                              width,
                              height,

                              title: "إجمالى رصيد الجمعية",

                              value: "${dashboard.emergencyFundBalance} ج.م",
                            ),

                            SizedBox(height: height * 0.03),

                            Text(
                              "الإحصائيات",

                              style: GoogleFonts.manrope(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            SizedBox(height: height * 0.02),

                            Row(
                              children: [
                                Expanded(
                                  child: statCard(
                                    width,

                                    ImageAssets.totalDonation,

                                    "إجمالى التبرعات",

                                    "${dashboard.totalDonations} ج.م",
                                  ),
                                ),

                                SizedBox(width: width * 0.05),

                                Expanded(
                                  child: statCard(
                                    width,

                                    ImageAssets.numDonors,

                                    "عدد المتبرعين",

                                    "${dashboard.totalDonors} متبرع",
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.02),

                            Row(
                              children: [
                                Expanded(
                                  child: statCard(
                                    width,

                                    ImageAssets.numCases,

                                    "عدد الحالات",

                                    "${dashboard.totalCases} حالة",
                                  ),
                                ),

                                SizedBox(width: width * 0.05),

                                Expanded(
                                  child: statCard(
                                    width,

                                    ImageAssets.compImg,

                                    "عدد الحملات",

                                    "${dashboard.totalCampaigns} حملة",
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.03),

                            /// monthly growth
                            infoCard(
                              width,
                              height,

                              title: "النمو الشهرى",

                              value:
                                  "%${dashboard.monthlyGrowthPercent} من الشهر الماضى",

                              showTrend: true,
                            ),

                            SizedBox(height: height * 0.02),

                            /// chart
                            WeeklyChart(
                              title: "التبرعات خلال الفترة",

                              weeklyGrowth: dashboard.weeklyGrowth,

                              monthlyGrowth: dashboard.monthlyGrowth,
                            ),

                            SizedBox(height: height * 0.03),

                            /// emergency fund
                            infoCard(
                              width,
                              height,

                              title: "صندوق الطوارئ",

                              value:
                                  "الرصيد المتاح: ${dashboard.emergencyFundBalance} ج.م",
                            ),

                            SizedBox(height: height * 0.02),

                            Text(
                              "التبرعات حسب الفئة",

                              style: GoogleFonts.manrope(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            DonationsChart(
                              categories: dashboard.categoryDistribution,
                            ),

                            SizedBox(height: height * 0.02),

                            /// not exist in backend ??
                            // sectionList(
                            //   title: "أكثر الحالات تبرعا",
                            //   width: width,
                            //   dashboard: dashboard,
                            // ),

                            // sectionList(
                            //   title: "أكثر الحملات تبرعا",
                            //   width: width,
                            //   dashboard: dashboard,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget infoCard(
    double width,
    double height, {
    required String title,
    required String value,
    bool showTrend = false,
  }) {
    return Container(
      padding: EdgeInsets.all(width * 0.04),

      decoration: BoxDecoration(
        color: const Color(0xff2F674D),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white, size: 25),

                SizedBox(width: width * 0.03),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        title,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: [
                          showTrend
                              ? const Directionality(
                                textDirection: TextDirection.ltr,

                                child: Icon(
                                  Icons.trending_up,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              )
                              : const SizedBox(),

                          Text(
                            value,

                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
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

          const Column(
            children: [
              Align(
                alignment: Alignment.topLeft,

                child: Icon(Icons.north_west, color: Colors.white),
              ),

              SizedBox(height: 8),

              Text("عرض التفاصيل", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget statCard(double width, String image, String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: width * 0.03),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: const Color(0xffE3F0EA),
              borderRadius: BorderRadius.circular(45),
            ),

            child: Image(image: AssetImage(image), height: 30),
          ),

          SizedBox(height: width * 0.02),

          Text(
            title,
            textAlign: TextAlign.center,

            style: GoogleFonts.manrope(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w800,
              color: const Color(0xff6A6969),
            ),
          ),

          Text(
            value,

            style: GoogleFonts.manrope(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionList({
    required String title,
    required double width,
    required dynamic dashboard,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: width * 0.04),

        Text(
          title,

          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: width * 0.04),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),

          child: ListView.separated(
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: dashboard.categoryDistribution.length,

            separatorBuilder: (_, __) => const Divider(),

            itemBuilder: (_, index) {
              final item = dashboard.categoryDistribution[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,

                leading: const CircleAvatar(backgroundColor: Color(0xffDAEAE5)),

                title: Text(
                  item.categoryName,

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text("${item.percentage.toStringAsFixed(1)}%"),

                trailing: Text(
                  "${item.amount} ج.م",

                  style: const TextStyle(
                    color: Color(0xff255A41),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
