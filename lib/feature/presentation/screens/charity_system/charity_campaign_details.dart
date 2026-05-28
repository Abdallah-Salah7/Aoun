import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../data/repositories/camp_repository.dart';
import '../../../domain/entities/camp_entity.dart';
import '../widget/weekly_chart.dart';

class CharityCampaignDetails extends StatefulWidget {
  final CampaignEntity campaignData;

  final CampaignRepository repository; // تمرير الـ Repository

  const CharityCampaignDetails({
    super.key,
    required this.campaignData,
    required this.repository
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
    _loadFullDetails();
  }

  Future<void> _loadFullDetails() async {
    try {
      final data = await widget.repository.getDetails(widget.campaignData.id);
      if (mounted) {
        setState(() {
          fullDetails = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = fullDetails ?? widget.campaignData;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text("تفاصيل الحملة", style: GoogleFonts.manrope(fontSize: 23, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          toolbarHeight: 70,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      data.imageUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (c, o, s) => Image.asset(ImageAssets.upload, height: 220, width: double.infinity, fit: BoxFit.cover),
                    ),
                  ),

                  // باقي الـ UI كما هو مع استبدال القيم بـ data.property
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.title, style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 14),
                          LinearProgressIndicator(value: data.rateValue, minHeight: 8, color: const Color(0xff2F5D46)),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("تم جمع ${data.collectedAmount} ج.م", style: const TextStyle(fontSize: 16, color: Color(0xff2F5D46), fontWeight: FontWeight.bold)),
                              Text("${data.donorsCount} متبرع", style: const TextStyle(fontSize: 16, color: Color(0xff6E6E6E), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // عرض الوصف
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.all(18),
                    child: Text(
                      data.description.isNotEmpty ? data.description : "لا يوجد وصف متاح",
                      style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xff757575)),
                    ),
                  ),

                  // التواريخ
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDateBox("بداية الحملة", data.startDate),
                        _buildDateBox("نهاية الحملة", data.endDate),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  WeeklyChart(title: "نمو التبرعات", weeklyGrowth: [], monthlyGrowth: []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBox(String title, DateTime date) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
          child: Text("${date.day}/${date.month}/${date.year}"),
        ),
      ],
    );
  }
}