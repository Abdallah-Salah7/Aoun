import 'package:aoun/feature/data/models/charity_details_model.dart';
import 'package:aoun/feature/presentation/screens/widget/info_col.dart';
import 'package:aoun/feature/presentation/screens/widget/section_card.dart';
import 'package:flutter/material.dart';

class BasicInfoCard extends StatelessWidget {
  final CharityDetailsModel charity;
  const BasicInfoCard({required this.charity});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "البيانات الأساسية",
      child: Column(
        children: [
          InfoColumn(title: "اسم الجمعية", value: charity.charityName),
          InfoColumn(title: "رقم القيد", value: charity.licenseNumber),
          InfoColumn(title: "تاريخ التقديم", value: charity.createdAt),
          InfoColumn(
            title: "نبذة عن الجمعية",
            value: charity.description,
            multiLine: true,
          ),
        ],
      ),
    );
  }
}