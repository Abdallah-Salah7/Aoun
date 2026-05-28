import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/growth_entity.dart';

class WeeklyChart extends StatefulWidget {
  final String title;
  final List<GrowthEntity> weeklyGrowth;
  final List<GrowthEntity> monthlyGrowth;

  const WeeklyChart({
    super.key,
    required this.title,
    required this.weeklyGrowth,
    required this.monthlyGrowth,
  });

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  bool isWeekly = true;

  List<FlSpot> _generateSpots(List<GrowthEntity> data) {
    return List.generate(
      data.length,
          (index) => FlSpot(
        index.toDouble(),
        data[index].amount.toDouble(),
      ),
    );
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 100;

    final max =
    spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    return max + (max * 0.15);
  }

  @override
  Widget build(BuildContext context) {
    final currentData =
    isWeekly ? widget.weeklyGrowth : widget.monthlyGrowth;

    final spots = _generateSpots(currentData);

    final maxX = spots.isEmpty ? 0.0 : spots.last.x;
    final maxY = _getMaxY(spots);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize:
                  MediaQuery.of(context).size.width *
                      0.042,
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

          const SizedBox(height: 24),

          /// CHART
          SizedBox(
            height: 260,
            child: spots.isEmpty
                ? const Center(
              child: Text(
                "لا توجد بيانات",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : LineChart(
              LineChartData(
                minX: 0,
                maxX: maxX,
                minY: 0,
                maxY: maxY,

                borderData:
                FlBorderData(show: false),

                /// GRID
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval:
                  maxY / 4,
                  getDrawingHorizontalLine:
                      (value) {
                    return FlLine(
                      color:
                      Colors.grey.shade300,
                      strokeWidth: 1.2,
                      dashArray: [6, 4],
                    );
                  },
                ),

                /// TITLES
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: maxY / 4,
                      getTitlesWidget:
                          (value, meta) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(
                              right: 8),
                          child: Text(
                            value
                                .toInt()
                                .toString(),
                            style:
                            const TextStyle(
                              fontSize: 11,
                              color:
                              Colors.grey,
                              fontWeight:
                              FontWeight
                                  .w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles:
                  AxisTitles(
                    sideTitles:
                    SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget:
                          (value, meta) {
                        final index =
                        value.toInt();

                        if (index >= 0 &&
                            index <
                                currentData
                                    .length) {
                          final date =
                              currentData[
                              index]
                                  .date;

                          const monthMap =
                          {
                            "Jan":
                            "يناير",
                            "Feb":
                            "فبراير",
                            "Mar":
                            "مارس",
                            "Apr":
                            "أبريل",
                            "May":
                            "مايو",
                            "Jun":
                            "يونيو",
                            "Jul":
                            "يوليو",
                            "Aug":
                            "أغسطس",
                            "Sep":
                            "سبتمبر",
                            "Oct":
                            "أكتوبر",
                            "Nov":
                            "نوفمبر",
                            "Dec":
                            "ديسمبر",
                          };

                          final arabicDate =
                              monthMap[
                              date] ??
                                  date;

                          return Padding(
                            padding:
                            const EdgeInsets.only(
                                top:
                                10),
                            child: Text(
                              arabicDate,
                              style:
                              const TextStyle(
                                fontSize:
                                10,
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),

                  rightTitles:
                  const AxisTitles(
                    sideTitles:
                    SideTitles(
                        showTitles:
                        false),
                  ),

                  topTitles:
                  const AxisTitles(
                    sideTitles:
                    SideTitles(
                        showTitles:
                        false),
                  ),
                ),

                /// LINE
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color:
                    const Color(
                        0xff000000),
                    barWidth: 2,
                    isStrokeCapRound:
                    true,

                    dotData:
                    FlDotData(
                      show: true,
                      getDotPainter:
                          (
                          spot,
                          percent,
                          barData,
                          index,
                          ) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color:
                          const Color(
                              0xff2F674D),
                          strokeWidth:
                          2,
                          strokeColor:
                          Colors
                              .white,
                        );
                      },
                    ),

                    belowBarData:
                    BarAreaData(
                      show: true,
                      gradient:
                      LinearGradient(
                        begin:
                        Alignment
                            .topCenter,
                        end: Alignment
                            .bottomCenter,
                        colors: [
                          const Color(
                              0xff2F674D)
                              .withOpacity(
                              0.25),
                          Colors
                              .transparent,
                        ],
                      ),
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

  Widget _buildTab(
      String text,
      bool weekly,
      ) {
    final isSelected =
        isWeekly == weekly;

    return GestureDetector(
      onTap: () {
        setState(() {
          isWeekly = weekly;
        });
      },
      child: AnimatedContainer(
        duration:
        const Duration(
            milliseconds: 250),
        padding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(
              0xff2F674D)
              : const Color(
              0xffE7E7E7),
          borderRadius:
          BorderRadius.circular(
              20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black87,
            fontWeight:
            FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}