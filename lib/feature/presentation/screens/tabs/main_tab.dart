import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../state_management/cubit/camp_cubit.dart';
import '../../state_management/cubit/camp_state.dart';
import '../donor_system/current_campaigns_screen.dart';
import '../widget/case_item.dart';
import '../widget/cradles_item.dart';
import '../widget/donation_item.dart';
import '../widget/title_item.dart';

class MainTab extends StatelessWidget {
  final VoidCallback onSeeMorePressed;

  const MainTab({super.key, required this.onSeeMorePressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff255A4230),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage(ImageAssets.logo)),
                        ),
                      ),
                      title: Text(
                        "مرحبا بك فى عون",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.w900, // SemiBold
                          color: const Color(0xff252424),
                        ),
                      ),
                      subtitle: Text(
                        "عون … الخير يبدأ بك",
                        style: GoogleFonts.manrope(
                          fontSize: 19,
                          color: Color(0xff6A6969),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.searchScreen,
                                );
                              },
                              child: Image.asset(
                                ImageAssets.search,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.notificationScreen,
                                );
                              },
                              child: Image.asset(
                                ImageAssets.bell,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          TitleItem(
                            color: const Color(0xff252424),
                            name: "مجالات التبرع",
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              onSeeMorePressed();
                            },
                            child: TitleItem(
                              color: const Color(0xff757575),
                              name: "عرض المزيد",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            DonationItem(
                              image: ImageAssets.siren,
                              name: "الإغاثة",
                              categoryId: 3,
                            ),
                            SizedBox(width: 4),

                            DonationItem(
                              image: ImageAssets.elderly,
                              name: "ذوى الإحتياجات",
                              categoryId: 7,
                            ),
                            SizedBox(width: 4),
                            DonationItem(
                              image: ImageAssets.brickWall,
                              name: "مشاريع بناء",
                              categoryId: 5,
                            ),
                            SizedBox(width: 12),

                            DonationItem(
                              image: ImageAssets.socialCare,
                              name: "كفالات",
                              categoryId: 4,
                            ),
                            SizedBox(width: 12),

                            DonationItem(
                              image: ImageAssets.classroom,
                              name: "التعليم",
                              categoryId: 2,
                            ),
                            SizedBox(width: 12),

                            DonationItem(
                              image: ImageAssets.healthCheck,
                              name: "الصحة",
                              categoryId: 1,
                            ),
                            SizedBox(width: 12),

                            DonationItem(
                              image: ImageAssets.deliveryMan,
                              name: "الإطعام",
                              categoryId: 10,
                            ),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          TitleItem(
                            color: const Color(0xff252424),
                            name: "الحملات الحالية",
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => BlocProvider.value(
                                        value: context.read<CampaignCubit>(),
                                        child: CurrentCampaignsScreen(),
                                      ),
                                ),
                              );
                            },
                            child: TitleItem(
                              color: const Color(0xff757575),
                              name: "عرض المزيد",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: BlocBuilder<CampaignCubit, CampaignState>(
                        builder: (context, state) {
                          if (state is CampaignLoaded) {
                            final campaigns = state.campaigns;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: campaigns.length,
                              itemBuilder: (context, index) {
                                final campaign = campaigns[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: CradlesItem(
                                  image: campaign.imageUrl,
                                  title: campaign.title,
                                  description: campaign.description,
                                  rateValue: campaign.rateValue,
                                  collectedValue: campaign.collectedAmount.toString(),
                                  allValue: campaign.requiredAmount.toString(),
                                  startDate: campaign.startDate,
                                  endDate: campaign.endDate,
                                    donorsCount: campaign.donorsCount,
                                    daysLeft: campaign.daysLeft,
                                )
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(height: 26),

    // CaseItem(
    // caseEntity: caseItem,
    // ),
    //                 SizedBox(height: 30),
    //
    //                 CaseItem(
    //                   caseEntity: caseItem,
    //                 ),
    //                 SizedBox(height: 30),
    //
    //                 CaseItem(
    //                   caseEntity: caseItem,
    //                 ),
    //                 SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
