import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonationChart extends StatelessWidget {
  const DonationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "التبرعات حسب الفئة",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 199,
                  height: 164,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: [
                        PieChartSectionData(
                          value: 20,
                          color: Color(0xff3A7E55),
                          radius: 30,
                          showTitle: false,
                        ),

                        PieChartSectionData(
                          value: 20,
                          color: Color(0xff1D4532),
                          radius: 30,
                          showTitle: false,
                        ),

                        PieChartSectionData(
                          value: 15,
                          color: Color(0xff1B6F48),
                          radius: 30,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 10,
                          color: Color(0xff74D1A5),
                          radius: 30,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 9,
                          color: Color(0xff5A9C7D),
                          radius: 30,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 7,
                          color: Color(0xff93B3A4),
                          radius: 30,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 5,
                          color: Color(0xff22A668),
                          radius: 30,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 25,
                          color: Color(0xff94D097),
                          radius: 30,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ChartItem(color: Color(0xff3A7E55), text: "الصحة"),
                  ChartItem(color: Color(0xff94D097), text: "التعليم"),
                  ChartItem(color: Color(0xff22A668), text: "الإغاثة"),
                  ChartItem(color: Color(0xff93B3A4), text: "مشاريع بناء"),
                  ChartItem(color: Color(0xff5A9C7D), text: "الإطعام"),
                  ChartItem(color: Color(0xff1D4532), text: "أخرى"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartItem extends StatelessWidget {
  final Color color;
  final String text;

  const ChartItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
