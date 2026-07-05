import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/data_sources/api_services.dart';

class DonationRecord extends StatefulWidget {
  const DonationRecord({super.key});

  @override
  State<DonationRecord> createState() => _DonationRecordState();
}

class _DonationRecordState extends State<DonationRecord> {
  late Future<List<dynamic>> donationsFuture;

  final Dio dio = Dio(BaseOptions(baseUrl: "https://aounplatform.runasp.net"));
  Future<List<dynamic>> fetchDonations() async {
    try {
      final token = await ApiServices.getDonorToken();

      final response = await dio.get(
        "/api/user/activity/donations-history",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    donationsFuture = fetchDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "سجل التبرعات",
            style: GoogleFonts.saira(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color(0xff255A41),
            ),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: donationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
            }
            final donations = snapshot.data ?? [];
            if (donations.isEmpty) {
              return Center(
                child: Text(
                  "لا يوجد تبرعات حتى الآن",
                  style: GoogleFonts.saira(fontSize: 20, color: Colors.grey),
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.3), blurRadius: 8),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: donations.length,

                separatorBuilder:
                    (_, __) => Divider(color: Colors.grey.shade300, height: 1),

                itemBuilder: (context, index) {
                  final donation = donations[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),

                    leading: ClipOval(
                      child: Image.asset(
                        ImageAssets.caseRec,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      donation["targetTitle"] ?? "",
                      style: GoogleFonts.saira(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),

                    subtitle: Text(
                      donation["date"].toString().split("T")[0],

                      style: GoogleFonts.saira(color: Colors.grey),
                    ),

                    trailing: Text(
                      "${donation["amount"]} ج.م",

                      style: GoogleFonts.saira(
                        color: const Color(0xff255A41),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
