import 'package:flutter/material.dart';
import 'package:aoun/feature/presentation/screens/charity_system/profile_donor.dart';

import '../../../domain/entities/top_donor_entity.dart';

class TopDonorsScreen extends StatelessWidget {
  final List<TopDonorEntity> donors;

  const TopDonorsScreen({
    super.key,
    required this.donors,
  });

  String getInitials(String name) {
    final words = name.trim().split(' ');

    if (words.isEmpty || words.first.isEmpty) {
      return '?';
    }

    if (words.length == 1) {
      return words.first[0];
    }

    return words[0][0] + words[1][0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "الأشخاص الأكثر تبرعاً",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: donors.length,
          itemBuilder: (context, index) {
            final donor = donors[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>ProfileDonor(
                      name: donor.donorName,
                    ),
                  ),
                );
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffE6F3EC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xff2F674D),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child:Text(
                          getInitials(donor.donorName[0]),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff2F674D),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donor.donorName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                           "${donor.donationsCount} تبرع",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                 "${donor.totalAmount} ج.م",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2F674D),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
