import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/data_sources/case_api_service.dart';
import '../../state_management/cubit/case_cubit.dart';
import 'charity_profile_screen.dart';

class CaseDetailsScreen extends StatefulWidget {
  final int caseId;

  const CaseDetailsScreen({
    super.key,
    required this.caseId,
  });

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  bool isSaved = false;
  late Future caseFuture;

  @override
  void initState() {
    super.initState();

    caseFuture = CaseApiService().getCaseById(widget.caseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: caseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "حدث خطأ أثناء تحميل البيانات",
                style: GoogleFonts.cairo(),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("لا توجد بيانات"),
            );
          }

          final data = snapshot.data!.data['data'];

          print("CASE DETAILS = $data");
          final String title = data["title"] ?? "";

          final String description =
              data["description"] ?? "";

          final String image =
              data["imageUrl"] ?? "";

          final int donorsCount =
              data["donorsCount"] ?? 0;

          final double collected =
              (data["collectedAmount"] as num?)
                  ?.toDouble() ??
                  0.0;

          final double required =
              (data["requiredAmount"] as num?)
                  ?.toDouble() ??
                  0.0;

          final bool isCompleted =
              data["isCompleted"] ?? false;

          final double progress =
              ((data["progress"] as num?)
                  ?.toDouble() ??
                  0.0) /
                  100;

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          buildCaseImage(image),

                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff387056),
                                  borderRadius:
                                  BorderRadius.circular(45),
                                ),
                                margin: const EdgeInsets.all(8),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff387056),
                                  borderRadius:
                                  BorderRadius.circular(45),
                                ),
                                margin: const EdgeInsets.all(8),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSaved = !isSaved;
                                    });
                                  },
                                  icon: Icon(
                                    isSaved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          child: Text(
                            title,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.all(18.0),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor:
                                  const Color(0xffD9D9D9),
                                  color:
                                  const Color(0xff255A41),
                                ),
                              ),
                            ),

                            isCompleted
                                ? Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Align(
                                alignment:
                                Alignment.topRight,
                                child: Text(
                                  "تم جمع 100%",
                                  style:
                                  GoogleFonts.manrope(
                                    fontSize: 17,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: const Color(
                                        0xff757575),
                                  ),
                                ),
                              ),
                            )
                                : Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "تم جمع $collected ج.م",
                                    style:
                                    GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: const Color(
                                          0xff255A41),
                                    ),
                                  ),

                                  const Spacer(),

                                  Text(
                                    "من $required",
                                    style:
                                    GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: const Color(
                                          0xff757575),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8),
                                    child: Image.asset(
                                      ImageAssets.vector,
                                    ),
                                  ),

                                  Text(
                                    "$donorsCount متبرع",
                                    style:
                                    GoogleFonts.manrope(
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: const Color(
                                          0xff757575),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "تفاصيل الحالة",
                              style: GoogleFonts.manrope(
                                fontSize: 23,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              description,
                              style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold,
                                color:
                                const Color(0xff757575),
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider.value(
                                    value:
                                    context.read<CaseCubit>(),
                                    child:
                                    const CharityProfileScreen(),
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "مقدمة من",
                                  style:
                                  GoogleFonts.manrope(
                                    fontSize: 23,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: const Color(
                                        0xff757575),
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        45),
                                    child: Image.asset(
                                      ImageAssets.ghaith,
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    "غيث للتنمية المجتمعية",
                                    style:
                                    GoogleFonts.manrope(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: const Color(
                                          0xff757575),
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
                        const EdgeInsets.all(18.0),
                        child: Center(
                          child: isCompleted
                              ? Container(
                            width: double.infinity,
                            padding:
                            const EdgeInsets
                                .symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xff8FAF9A),
                              borderRadius:
                              BorderRadius
                                  .circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: const [
                                Text(
                                  "اكتملت",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    color:
                                    Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons
                                      .check_circle_outline,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ],
                            ),
                          )
                              : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style:
                              ElevatedButton
                                  .styleFrom(
                                backgroundColor:
                                const Color(
                                    0xff2F674D),
                                foregroundColor:
                                Colors.white,
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  vertical: 14,
                                ),
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes
                                      .paymentScreen,
                                );
                              },
                              child: Text(
                                "تبرع الآن",
                                style:
                                GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
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
    );
  }

  Widget _placeholder() {
    return Container(
      height: 292,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.image_not_supported,
        size: 60,
        color: Colors.grey,
      ),
    );
  }

  Widget buildCaseImage(String? image) {
    final safeImage = image ?? "";

    if (safeImage.startsWith('http')) {
      return Image.network(
        safeImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 292,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    if (safeImage.startsWith('/')) {
      return Image.network(
        "https://aounplatform.runasp.net$safeImage",
        fit: BoxFit.cover,
        width: double.infinity,
        height: 292,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    if (safeImage.startsWith('file://')) {
      return Image.file(
        File(safeImage.replaceFirst('file://', '')),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 292,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    return _placeholder();
  }
}