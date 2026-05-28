import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/camp_entity.dart';
import '../../state_management/cubit/camp_cubit.dart';
import '../charity_system/edit_campaign.dart';

class CharityCampaignItem extends StatelessWidget {
  final CampaignEntity campaign;

  const CharityCampaignItem({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.charityCampaignDetails,
          arguments: campaign,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // في ملف CharityCampaignItem.dart، استبدلي جزء عرض الصورة بـ:
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: campaign.imageUrl.startsWith('http')
                  ? Image.network(
                campaign.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(ImageAssets.upload, height: 220, width: double.infinity, fit: BoxFit.cover),
              )
                  : Image.asset(
                campaign.imageUrl.isNotEmpty ? campaign.imageUrl : ImageAssets.upload,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // التاريخ والعنوان
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(ImageAssets.iconDate, height: 34, width: 34),
                      const SizedBox(width: 8),
                      Text("${campaign.daysLeft} يوم متبقى", style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black45)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(alignment: Alignment.topRight, child: Text(campaign.title, style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // شريط التقدم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: LinearProgressIndicator(value: campaign.rateValue.clamp(0.0, 1.0), minHeight: 6, color: const Color(0xff2F674D), backgroundColor: const Color(0xffE0E0E0)),
            ),

            // القيم والإحصائيات
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("تم جمع ${campaign.collectedAmount.toInt()} ج.م", style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xff255A41))),
                    Text("من ${campaign.requiredAmount.toInt()}", style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xff757575))),
                  ]),
                  const Spacer(),
                  Column(children: [
                    Image.asset(ImageAssets.vector),
                    Text("${campaign.donorsCount} متبرع", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ]),
                ],
              ),
            ),

            // زر الحالة أو التعديل
            campaign.isCompleted ? _buildCompletedButton() : _buildEditButton(context),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedButton() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: const Color(0xff8FAF9A), borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("اكتملت", style: GoogleFonts.manrope(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(width: 5),
      const Icon(Icons.check_circle_outline, color: Colors.white, size: 36),
    ]),
  );

  Widget _buildEditButton(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), side: const BorderSide(color: Color(0xff737373), width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<CampaignCubit>(), child: EditCampaign(campaignEntity: campaign))));
        },
        icon: const Icon(Icons.mode_edit_outline_outlined, color: Color(0xff737373), size: 30),
        label: Text("تعديل الحملة", style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xff737373))),
      ),
    ),
  );
}