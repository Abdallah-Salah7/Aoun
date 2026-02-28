
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes_manager/routes.dart';

class DonationItem extends StatelessWidget {
  final String image;
  final String name;

  const DonationItem({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.donationFieldScreen,
          arguments: name,
        );
      },

      child: Expanded(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffBFDCCF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(image,
                width: 37,
                height: 37,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                name,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: const Color(0xff323131),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}