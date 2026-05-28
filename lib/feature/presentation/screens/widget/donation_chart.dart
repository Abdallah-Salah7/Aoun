import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../domain/entities/category_distribution_entity.dart';
import 'chart_item.dart';

class DonationChart extends StatelessWidget {
  final List<CategoryDistributionEntity> categories;

  const DonationChart({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xff3A7E55),
      const Color(0xff1D4532),
      const Color(0xff1B6F48),
      const Color(0xff74D1A5),
      const Color(0xff5A9C7D),
      const Color(0xff93B3A4),
      const Color(0xff22A668),
      const Color(0xff94D097),
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  "التبرعات حسب الفئة",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 199,
                  height: 164,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: List.generate(categories.length, (index) {
                        final item = categories[index];

                        return PieChartSectionData(
                          value: item.amount,
                          color: colors[index % colors.length],
                          radius: 30,
                          showTitle: false,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 30),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(categories.length, (index) {
                  final item = categories[index];

                  return ChartItem(
                    color: colors[index % colors.length],
                    text: item.categoryName,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}