import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonationsChart extends StatelessWidget {
  const DonationsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الإجمالي',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          /// CHART
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = [
                          'الصحة',
                          'الإغاثة',
                          'التعليم',
                          'كفالات',
                          'بناء',
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            titles[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),

                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                barGroups: [
                  _bar(0, 17000),
                  _bar(1, 4000),
                  _bar(2, 8000),
                  _bar(3, 5000),
                  _bar(4, 10000),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// LEGEND
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('2', style: TextStyle(fontSize: 10)),
              SizedBox(width: 4),
              Icon(Icons.square, size: 10, color: Color(0xFF3A6F5D)),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 25,
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF3A6F5D),
        ),
      ],
    );
  }
}
