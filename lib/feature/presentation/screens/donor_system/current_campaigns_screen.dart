import 'package:aoun/feature/presentation/screens/widget/campaign_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state_management/cubit/camp_cubit.dart';
import '../../state_management/cubit/camp_state.dart';


class CurrentCampaignsScreen extends StatefulWidget {
  CurrentCampaignsScreen({super.key});

  @override
  State<CurrentCampaignsScreen> createState() => _CurrentCampaignsScreenState();
}

class _CurrentCampaignsScreenState extends State<CurrentCampaignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 162,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 38.0, right: 80),
            child: Row(
              children: [
                Text(
                  "الحملات",
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700, // SemiBold
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),

        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10),

                BlocBuilder<CampaignCubit, CampaignState>(
                  builder: (context, state) {
                    if (state is CampaignLoaded) {
                      final campaigns = state.campaigns;

                      final filteredCampaigns = campaigns;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredCampaigns.length,
                        itemBuilder: (context, index) {
                          final campaign = filteredCampaigns[index];
                          return CampaignItem(
                            campaignId: campaign.id,
                            image: campaign.imageUrl,
                            title: campaign.title,
                            rateValue: campaign.rateValue,
                            collectedValue: campaign.collectedAmount.toString(),
                            allValue: campaign.requiredAmount.toString(),
                            description: campaign.description,
                            startDate: campaign.startDate,
                            endDate: campaign.endDate,
                            daysLeft: campaign.daysLeft,
                            donorsCount: campaign.donorsCount,
                          );
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
