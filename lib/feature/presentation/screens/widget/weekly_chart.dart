import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyChart extends StatefulWidget {
  String title;
  WeeklyChart({super.key, required this.title});

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  bool isWeekly = true;

  final List<FlSpot> weeklySpots = [
    FlSpot(0, 5200),
    FlSpot(1, 6400),
    FlSpot(2, 5700),
    FlSpot(3, 6700),
    FlSpot(4, 6100),
    FlSpot(5, 7200),
    FlSpot(6, 8000),
  ];

  final List<FlSpot> monthlySpots = [
    FlSpot(0, 5000),
    FlSpot(1, 5500),
    FlSpot(2, 5800),
    FlSpot(3, 6000),
    FlSpot(4, 6500),
    FlSpot(5, 7000),
    FlSpot(6, 7200),
    FlSpot(7, 7500),
    FlSpot(8, 7800),
    FlSpot(9, 8000),
    FlSpot(10, 8300),
    FlSpot(11, 8500),
  ];

  @override
  Widget build(BuildContext context) {
    final spots = isWeekly ? weeklySpots : monthlySpots;
    final maxX = spots.last.x;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,

                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                ),
              ),
              Row(
                children: [
                  _buildTab("أسبوعي", true),
                  const SizedBox(width: 8),
                  _buildTab("شهري", false),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 5000,
                maxY: 9000,
                minX: 0,
                maxX: maxX,
                borderData: FlBorderData(show: false),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade400,
                      strokeWidth: 1.5,
                      dashArray: [5, 5],
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1000,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 10),
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (isWeekly) {
                          const days = [
                            "Sat",
                            "Sun",
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                        } else {
                          return Text("M${value.toInt() + 1}");
                        }
                        return const SizedBox();
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

                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.black,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xff2F674D),
                          strokeWidth: 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool weekly) {
    final isSelected = isWeekly == weekly;

    return GestureDetector(
      onTap: () {
        setState(() {
          isWeekly = weekly;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2C5240) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
