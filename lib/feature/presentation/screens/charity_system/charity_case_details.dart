import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/dashboard_cubit.dart';
import '../../state_management/cubit/dashboard_state.dart';
import '../widget/weekly_chart.dart';

class CharityCaseDetails extends StatefulWidget {
  final CaseEntity caseData;

  const CharityCaseDetails({
    super.key,
    required this.caseData,
  });

  @override
  State<CharityCaseDetails> createState() =>
      _CharityCaseDetailsState();
}

class _CharityCaseDetailsState
    extends State<CharityCaseDetails> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DashboardCubit>().getDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.caseData.title;
    final rateValue = widget.caseData.progress;
    final collectedValue =
        widget.caseData.collectedAmount;
    final allValue = widget.caseData.requiredAmount;
    final description =
        widget.caseData.description;
    final donorCount =
        widget.caseData.donorCount;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          title: Text(
            "تفاصيل الحالة",
            style: GoogleFonts.manrope(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          centerTitle: true,

          leading: GestureDetector(
            onTap: () => Navigator.pop(context),

            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.black,
            ),
          ),

          toolbarHeight: 70,
        ),

        body: BlocBuilder<
            DashboardCubit,
            DashboardState
        >(
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.all(8.0),

                  child: Directionality(
                    textDirection:
                    TextDirection.rtl,

                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),

                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(
                                  16,
                                ),

                                child: Image.network(
                                  "https://aounplatform.runasp.net${widget.caseData.imageUrl}",

                                  height: 198,
                                  width:
                                  double.infinity,
                                  fit: BoxFit.cover,

                                  errorBuilder:
                                      (
                                      context,
                                      error,
                                      stackTrace,
                                      ) {
                                    return Container(
                                      height: 198,
                                      width:
                                      double.infinity,
                                      color:
                                      Colors.grey
                                          .shade300,

                                      child: const Icon(
                                        Icons
                                            .image_not_supported,
                                        size: 50,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        Align(
                          alignment:
                          Alignment.topRight,

                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 28.0,
                            ),

                            child: Text(
                              title,

                              style:
                              GoogleFonts.cairo(
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 18,
                              ),

                              textAlign:
                              TextAlign.start,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.all(
                            12.0,
                          ),

                          child: Container(
                            decoration:
                            BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                            ),

                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 28,
                            ),

                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                    10,
                                  ),

                                  child:
                                  LinearProgressIndicator(
                                    value: rateValue,

                                    minHeight: 8,

                                    backgroundColor:
                                    const Color(
                                      0xffCFCFCF,
                                    ),

                                    color:
                                    const Color(
                                      0xff2F5D46,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 14,
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                      children: [
                                        Text(
                                          "تم جمع $collectedValue ج.م",

                                          style:
                                          const TextStyle(
                                            fontSize:
                                            16,

                                            color:
                                            Color(
                                              0xff2F5D46,
                                            ),

                                            fontWeight:
                                            FontWeight
                                                .bold,
                                          ),
                                        ),

                                        Text(
                                          "من $allValue",

                                          style:
                                          const TextStyle(
                                            fontSize:
                                            15,

                                            color:
                                            Color(
                                              0xff6E6E6E,
                                            ),

                                            fontWeight:
                                            FontWeight
                                                .w500,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.group,

                                          color:
                                          Color(
                                            0xff2F5D46,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 6,
                                        ),

                                        Text(
                                          "$donorCount متبرع",

                                          style:
                                          const TextStyle(
                                            fontSize:
                                            16,

                                            color:
                                            Color(
                                              0xff6E6E6E,
                                            ),

                                            fontWeight:
                                            FontWeight
                                                .w600,
                                          ),
                                        ),
                                      ],
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
                            horizontal: 28.0,
                          ),

                          child: Align(
                            alignment:
                            Alignment.topRight,

                            child: Text(
                              "وصف الحالة",

                              style:
                              GoogleFonts.manrope(
                                fontSize: 20,

                                fontWeight:
                                FontWeight.bold,

                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                            BorderRadius.circular(
                              15,
                            ),
                          ),

                          width: double.infinity,

                          padding:
                          const EdgeInsets.all(
                            18,
                          ),

                          margin:
                          const EdgeInsets.all(
                            18,
                          ),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [
                              Text(
                                description,

                                style:
                                GoogleFonts.manrope(
                                  fontSize: 17,

                                  fontWeight:
                                  FontWeight.bold,

                                  color: const Color(
                                    0xff757575,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (state
                        is DashboardSuccess)
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 18,
                            ),

                            child: WeeklyChart(
                              title:
                              "نمو التبرعات",

                              weeklyGrowth: state
                                  .dashboard
                                  .weeklyGrowth,

                              monthlyGrowth: state
                                  .dashboard
                                  .monthlyGrowth,
                            ),
                          ),

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 8,
                          ),

                          child: Row(
                            children: const [
                              Text(
                                "آخر التبرعات",

                                style: TextStyle(
                                  fontSize: 22,

                                  fontWeight:
                                  FontWeight
                                      .w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.all(
                            18.0,
                          ),

                          child: Container(
                            padding:
                            const EdgeInsets.all(
                              16,
                            ),

                            margin:
                            const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

                            decoration:
                            BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),

                              boxShadow: const [
                                BoxShadow(
                                  color:
                                  Colors.black12,
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child:
                            ListView.separated(
                              shrinkWrap: true,

                              physics:
                              const NeverScrollableScrollPhysics(),

                              itemCount:
                              state
                              is DashboardSuccess
                                  ? state
                                  .dashboard
                                  .recentDonationStatistic
                                  .length
                                  : 0,

                              separatorBuilder:
                                  (
                                  context,
                                  index,
                                  ) =>
                              const Divider(),

                              itemBuilder:
                                  (
                                  context,
                                  index,
                                  ) {
                                final donation =
                                (state
                                as DashboardSuccess)
                                    .dashboard
                                    .recentDonationStatistic[index];

                                return ListTile(
                                  contentPadding:
                                  EdgeInsets.zero,

                                  leading:
                                  CircleAvatar(
                                    backgroundColor:
                                    const Color(
                                      0xffC7CDCD,
                                    ),

                                    child: Text(
                                      donation
                                          .donorName[0],

                                      style:
                                      const TextStyle(
                                        color:
                                        Color(
                                          0xFF1E5631,
                                        ),

                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),
                                  ),

                                  title: Text(
                                    donation
                                        .donorName,

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold,

                                      fontSize: 20,
                                    ),
                                  ),

                                  subtitle: Text(
                                    donation
                                        .targetName,

                                    style:
                                    const TextStyle(
                                      fontSize: 15,

                                      fontWeight:
                                      FontWeight
                                          .w400,
                                    ),
                                  ),

                                  trailing:
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,

                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,

                                    children: [
                                      Text(
                                        "${donation.amount} ج.م",

                                        style:
                                        const TextStyle(
                                          color:
                                          Color(
                                            0xff255A41,
                                          ),

                                          fontWeight:
                                          FontWeight
                                              .bold,

                                          fontSize:
                                          16,
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}