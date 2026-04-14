import 'package:flutter/material.dart';
import 'package:aoun/feature/presentation/screens/charity_system/profile_donor.dart';

class TopDonorsScreen extends StatelessWidget {
  const TopDonorsScreen({super.key});

  final List<Map<String, String>> donors = const [
    {"name": "أحمد علي", "donation": "24 تبرع", "amount": "5000 ج.م"},
    {"name": "فاطمة حسن", "donation": "15 تبرع", "amount": "5000 ج.م"},
    {"name": "خالد سيد", "donation": "15 تبرع", "amount": "5000 ج.م"},
    {"name": "مريم عبد الله", "donation": "15 تبرع", "amount": "5000 ج.م"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "الأشخاص الأكثر تبرعاً",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: donors.length,
          itemBuilder: (context, index) {
            final item = donors[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDonor(
                      name: item["name"]!,
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
                        child: Text(
                          item["name"]![0], // أول حرف من الاسم
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
                            item["name"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item["donation"]!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      item["amount"]!,
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