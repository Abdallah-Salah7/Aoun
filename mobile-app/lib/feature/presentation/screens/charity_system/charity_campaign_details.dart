import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../data/repositories_imp/camp_repository.dart';
import '../../../domain/entities/camp_entity.dart';
import '../widget/weekly_chart.dart';
import '../widget/weekly_chart_camp.dart';

class CharityCampaignDetails extends StatefulWidget {
  final CampaignEntity campaignData;
  final CampaignRepository repository;

  const CharityCampaignDetails({
    super.key,
    required this.campaignData,
    required this.repository,
  });

  @override
  State<CharityCampaignDetails> createState() => _CharityCampaignDetailsState();
}

class _CharityCampaignDetailsState extends State<CharityCampaignDetails> {
  CampaignEntity? fullDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data =
      await widget.repository.getDetails(widget.campaignData.id);

      if (mounted) {
        setState(() {
          fullDetails = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final data = fullDetails ?? widget.campaignData;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          title: Text(
            "تفاصيل الحملة",
            style: GoogleFonts.manrope(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          toolbarHeight: 70,
        ),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _buildImage(data.imageUrl),
                  ),

                  const SizedBox(height: 10),

                  /// TITLE
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        data.title,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// MAIN CARD
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// DAYS LEFT
                        Row(
                          children: [
                            Image.asset(
                              ImageAssets.iconDate,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${getRemainingDays(data.endDate)} يوم متبقى",
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        /// TITLE
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              data.title,
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// PROGRESS
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: data.rateValue,
                            minHeight: 8,
                            backgroundColor: const Color(0xffCFCFCF),
                            color: const Color(0xff2F5D46),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// AMOUNT + DONORS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "تم جمع ${data.collectedAmount} ج.م",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff2F5D46),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "من ${data.requiredAmount}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children:  [
                                Icon(Icons.group,
                                    color: Color(0xff2F5D46)),
                                SizedBox(height: 4),
                                Text("${data.donorsCount}متبرع",),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "وصف الحملة",
                        style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  /// DESCRIPTION
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      data.description,
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.0,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDateBox(
                          title: "بداية الحملة",
                          date: data.startDate,
                        ),
                        _buildDateBox(
                          title: "نهاية الحملة",
                          date: data.endDate,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// CHART
                  WeeklyCampChart(
                    title: "نمو التبرعات",
                    weeklyCampGrowth: data.weeklyCampDonations,
                    monthlyCampGrowth: data.monthlyCampDonations,
                  )

                  ,const SizedBox(height: 26),

                  /// DONATIONS TITLE
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "آخر التبرعات",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  Container(
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

                      itemCount: data.lastCampDonations.length,

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
                        final donation = data.lastCampDonations[index];

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
                              donation.userName.isNotEmpty
                                  ? donation.userName[0]
                                  : '?',

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
                            donation.userName,

                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold,

                              fontSize: 20,
                            ),
                          ),

                          subtitle: Text(
                            "${donation.date.day}/${donation.date.month}/${donation.date.year}",

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

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// IMAGE HANDLER (file / network / asset)
  Widget _buildImage(String image) {
    if (image.startsWith('/') || image.contains('cache')) {
      return Image.file(
        File(image),
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (image.startsWith('http')) {
      return Image.network(
        image,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Image.asset(ImageAssets.upload),
      );
    } else {
      return Image.asset(
        image,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  int getRemainingDays(DateTime? date) {
    if (date == null) return 0;

    final now = DateTime.now();
    final diff = date.difference(now).inDays;

    return diff < 0 ? 0 : diff;
  }

  Widget _buildDateBox({required String title, required DateTime? date}) {
    final String formattedDate = date == null
        ? "--/--/----"
        : "${date.day}/${date.month}/${date.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 41,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffC4C4C4),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            formattedDate,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }}