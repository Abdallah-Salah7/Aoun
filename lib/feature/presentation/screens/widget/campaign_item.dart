import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/models/payment_args.dart';
import '../../../domain/entities/camp_entity.dart';

class CampaignItem extends StatelessWidget {
  final CampaignEntity campEntity;


  const CampaignItem({
    super.key,
    required this.campEntity,

  });

  bool get isFileImage => campEntity.imageUrl.startsWith('/') || campEntity.imageUrl.startsWith('file://');
  bool get isNetworkImage => campEntity.imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final remaining = campEntity.requiredAmount - campEntity.collectedAmount;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.campaignDetails,
          arguments: campEntity.id,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child:
                    isNetworkImage
                        ? Image.network(
                      campEntity.imageUrl,
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                        : (isFileImage
                            ? Image.file(
                              File(campEntity.imageUrl),
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                      campEntity.imageUrl,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            )),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        campEntity.title,
                        style: GoogleFonts.saira(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            ImageAssets.iconDate,
                            height: 34,
                            width: 34,
                          ),
                        ),
                        Text(
                          "${campEntity.daysLeft} يوم متبقى",
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: campEntity.rateValue.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: const Color(0xffD9D9D9),
                    color: const Color(0xff255A41),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      "تم جمع ${campEntity.collectedAmount} ج.م",
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff255A41),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "من ${campEntity.requiredAmount}",
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F674D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.paymentScreen,
                        arguments: PaymentArgs(
                          isCase: false,
                          targetId: campEntity.id,
                          amount: remaining.toInt(),
                          targetType: "Campaign",
                          image: campEntity.imageUrl,
                          title: campEntity.title
                        ),
                      );
                    },

                    child: Text(
                      "تبرع الآن",
                      style: GoogleFonts.manrope(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getRemainingDays() {
    final date = campEntity.endDate;
    if (date == null) return 0;

    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    return difference < 0 ? 0 : difference;
  }
}
