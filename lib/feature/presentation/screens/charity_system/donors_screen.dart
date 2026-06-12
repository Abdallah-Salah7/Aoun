import 'package:aoun/feature/presentation/screens/charity_system/profile_donor.dart';
import 'package:aoun/feature/presentation/screens/charity_system/top_donors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/recent_donation_entity.dart';
import '../../state_management/cubit/dashboard_cubit.dart';
import '../../state_management/cubit/dashboard_state.dart';
import '../widget/weekly_chart.dart';
import 'app_drawer.dart';

class DonorsScreen extends StatefulWidget {
  const DonorsScreen({super.key});

  @override
  State<DonorsScreen> createState() =>
      _DonorsScreenState();
}

class _DonorsScreenState
    extends State<DonorsScreen> {


  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<DashboardCubit>()
          .getDashboardStats();
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

        appBar: AppBar(
          backgroundColor:
          const Color(0xff2F674D),

          toolbarHeight: 0,
        ),

        backgroundColor:
        const Color(0xffC7CDCD),

        body: BlocBuilder<
            DashboardCubit,
            DashboardState
        >(
          builder: (context, state) {

            if (state
            is DashboardLoading) {
              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }

            if (state
            is DashboardError) {
              return Center(
                child:
                Text(state.message),
              );
            }

            if (state
            is DashboardSuccess) {

              final dashboard =
                  state.dashboard;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Container(
                      decoration:
                      const BoxDecoration(
                        borderRadius:
                        BorderRadius.only(
                          bottomLeft:
                          Radius.circular(
                            25,
                          ),

                          bottomRight:
                          Radius.circular(
                            25,
                          ),
                        ),

                        color: Color(
                          0xff2F674D,
                        ),
                      ),

                      height: 148,

                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 32,
                        ),

                        child: Row(
                          children: [

                            Padding(
                              padding:
                              const EdgeInsets.only(
                                left: 28.0,
                                top: 18,
                              ),

                              child: Builder(
                                builder: (
                                    context,
                                    ) {
                                  return InkWell(
                                    onTap: () {
                                      Scaffold.of(
                                        context,
                                      ).openDrawer();
                                    },

                                    child: Image(
                                      image: AssetImage(
                                        ImageAssets
                                            .charityIcon,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.only(
                                top: 18.0,
                              ),

                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [

                                  Text(
                                    "المتبرعين",

                                    style:
                                    GoogleFonts.manrope(
                                      fontSize:
                                      22,

                                      fontWeight:
                                      FontWeight
                                          .w800,

                                      color:
                                      Colors.white,
                                    ),
                                  ),

                                  Text(
                                    "لوحة التحكم",

                                    style:
                                    GoogleFonts.manrope(
                                      fontSize:
                                      19,

                                      fontWeight:
                                      FontWeight
                                          .w400,

                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    /// total donors
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20,
                      ),

                      child: Container(
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),

                          color:
                          Colors.white,

                          boxShadow: [

                            BoxShadow(
                              color:
                              Colors.black
                                  .withOpacity(
                                0.25,
                              ),

                              blurRadius:
                              10,

                              spreadRadius:
                              1,

                              offset:
                              const Offset(
                                0,
                                6,
                              ),
                            ),
                          ],
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),

                        child: Row(
                          children: [

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                vertical:
                                12.0,

                                horizontal:
                                8,
                              ),

                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color:
                                  const Color(
                                    0xffE3F0EA,
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    45,
                                  ),
                                ),

                                padding:
                                const EdgeInsets.all(
                                  8,
                                ),

                                child: Image(
                                  image: AssetImage(
                                    ImageAssets
                                        .numDonors,
                                  ),

                                  height:
                                  36,

                                  width:
                                  36,
                                ),
                              ),
                            ),

                            Column(
                              children: [

                                Text(
                                  "إجمالى المتبرعين",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    19,

                                    fontWeight:
                                    FontWeight
                                        .w800,

                                    color:
                                    const Color(
                                      0xff6A6969,
                                    ),
                                  ),
                                ),

                                Text(
                                  "${dashboard.totalDonors} متبرع",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    17,

                                    fontWeight:
                                    FontWeight
                                        .w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// new donors
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20,
                      ),

                      child: Container(
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),

                          color:
                          Colors.white,

                          boxShadow: [

                            BoxShadow(
                              color:
                              Colors.black
                                  .withOpacity(
                                0.25,
                              ),

                              blurRadius:
                              10,

                              spreadRadius:
                              1,

                              offset:
                              const Offset(
                                0,
                                6,
                              ),
                            ),
                          ],
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),

                        child: Row(
                          children: [

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                vertical:
                                12.0,

                                horizontal:
                                8,
                              ),

                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color:
                                  const Color(
                                    0xffE3F0EA,
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    45,
                                  ),
                                ),

                                padding:
                                const EdgeInsets.all(
                                  8,
                                ),

                                child: Image(
                                  image: AssetImage(
                                    ImageAssets
                                        .newDonors,
                                  ),

                                  height:
                                  36,

                                  width:
                                  36,
                                ),
                              ),
                            ),

                            Column(
                              children: [

                                Text(
                                  "متبرعين جدد",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    19,

                                    fontWeight:
                                    FontWeight
                                        .w800,

                                    color:
                                    const Color(
                                      0xff6A6969,
                                    ),
                                  ),
                                ),

                                Text(
                                  "${dashboard.weeklyDonorsGrowth.fold(
                                    0,
                                        (
                                        sum,
                                        item,
                                        ) =>
                                    sum +
                                        item.amount
                                            .toInt(),
                                  )} متبرع",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    17,

                                    fontWeight:
                                    FontWeight
                                        .w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// total donations
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20,
                      ),

                      child: Container(
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),

                          color:
                          Colors.white,

                          boxShadow: [

                            BoxShadow(
                              color:
                              Colors.black
                                  .withOpacity(
                                0.25,
                              ),

                              blurRadius:
                              10,

                              spreadRadius:
                              1,

                              offset:
                              const Offset(
                                0,
                                6,
                              ),
                            ),
                          ],
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),

                        child: Row(
                          children: [

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                vertical:
                                12.0,

                                horizontal:
                                8,
                              ),

                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color:
                                  const Color(
                                    0xffE3F0EA,
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    45,
                                  ),
                                ),

                                padding:
                                const EdgeInsets.all(
                                  8,
                                ),

                                child: Image(
                                  image: AssetImage(
                                    ImageAssets
                                        .totalDonation,
                                  ),

                                  height:
                                  36,

                                  width:
                                  36,
                                ),
                              ),
                            ),

                            Column(
                              children: [

                                Text(
                                  "إجمالى التبرعات",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    19,

                                    fontWeight:
                                    FontWeight
                                        .w800,

                                    color:
                                    const Color(
                                      0xff6A6969,
                                    ),
                                  ),
                                ),

                                Text(
                                  "${dashboard.totalDonations} ج.م",

                                  style:
                                  GoogleFonts.manrope(
                                    fontSize:
                                    17,

                                    fontWeight:
                                    FontWeight
                                        .w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// chart
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 36.0,
                        horizontal: 18,
                      ),

                      child: WeeklyChart(
                        title:
                        "عدد المتبرعين",

                        weeklyGrowth:
                        dashboard
                            .weeklyDonorsGrowth,

                        monthlyGrowth:
                        dashboard
                            .monthlyDonorsGrowth,
                      ),
                    ),

                    TopDonorsScreen(
                      donors: dashboard.topDonors,
                    ),

                    /// title
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 28.0,
                      ),

                      child: Row(
                        children: [

                          const Text(
                            "جميع المتبرعين",

                            style: TextStyle(
                              fontSize: 22,
                              fontWeight:
                              FontWeight
                                  .w800,
                            ),
                          ),

                          const Spacer(),

                          InkWell(
                            onTap: () {},

                            child: const Text(
                              "عرض المزيد",

                              style: TextStyle(
                                fontSize:
                                22,

                                fontWeight:
                                FontWeight
                                    .w800,

                                color: Color(
                                  0xff248457,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// donors list
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
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
                          dashboard.allDonors.length,
                          separatorBuilder:
                              (context, index) =>
                          const Divider(),
                          itemBuilder: (context, index) {
                            final donor = dashboard.allDonors[index];

                            final recentDonation = dashboard.recentDonationStatistic.firstWhere(
                                  (item) => item.donorName == donor.donorName,
                              orElse: () => RecentDonationEntity(
                                donorName: '',
                                amount: 0,
                                targetName: '',
                                date: DateTime(1970),
                              ),
                            );

                            return ListTile(
                              contentPadding: EdgeInsets.zero,

                              leading: CircleAvatar(
                                backgroundColor: const Color(0xffC7CDCD),
                                child: Text(
                                  dashboard.allDonors[index]
                                      .donorName
                                      .trim()
                                      .isNotEmpty
                                      ? dashboard.allDonors[index]
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
                                donor.donorName,
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),

                              subtitle: Text(
                            recentDonation.donorName.isNotEmpty
                            ? formatTimeAgo(recentDonation.date)
                                : "لا توجد تبرعات",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),

                              trailing:  Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                              Text(
                              "${donor.totalAmount} ج.م",
                                    style: TextStyle(
                                      color:
                                      Color(0xff255A41),
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),


                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}