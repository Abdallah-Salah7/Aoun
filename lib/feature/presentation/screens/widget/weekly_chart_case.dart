import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/growth_case_entity.dart';

class WeeklyCaseChart extends StatefulWidget {
  final String title;
  final List<GrowthCaseEntity> weeklyCaseGrowth;
  final List<GrowthCaseEntity> monthlyCaseGrowth;

  const WeeklyCaseChart({
    super.key,
    required this.title,
    required this.weeklyCaseGrowth,
    required this.monthlyCaseGrowth,
  });

  @override
  State<WeeklyCaseChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyCaseChart> {
  bool isWeekly = true;

  List<GrowthCaseEntity> _prepareWeeklyData(
      List<GrowthCaseEntity> apiData,
      ) {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final day = now.subtract(
        Duration(days: 6 - index),
      );

      final label = DateFormat('dd/MM').format(day);

      final matched = apiData.where(
            (e) => e.date == label,
      );

      if (matched.isNotEmpty) {
        return matched.first;
      }

      return GrowthCaseEntity(
        date: label,
        amount: 0,
      );
    });
  }

  List<GrowthCaseEntity> _prepareMonthlyData(
      List<GrowthCaseEntity> apiData,
      ) {
    final now = DateTime.now();

    final daysInMonth =
        DateTime(now.year, now.month + 1, 0).day;

    return List.generate(daysInMonth, (index) {
      final day = index + 1;

      final label = day.toString().padLeft(2, '0');

      final matched = apiData.where((e) {
        final parts = e.date.split('/');

        if (parts.isEmpty) {
          return false;
        }

        return parts[0] == label;
      });

      if (matched.isNotEmpty) {
        return GrowthCaseEntity(
          date: label,
          amount: matched.first.amount,
        );
      }

      return GrowthCaseEntity(
        date: label,
        amount: 0,
      );
    });
  }

  List<FlSpot> _generateSpots(
      List<GrowthCaseEntity> data,
      ) {
    return List.generate(
      data.length,
          (index) => FlSpot(
        index.toDouble(),
        data[index].amount,
      ),
    );
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) {
      return 100;
    }

    final max =
    spots.map((e) => e.y).reduce(
          (a, b) => a > b ? a : b,
    );

    return max == 0
        ? 100
        : max + (max * 0.3);
  }

  @override
  Widget build(BuildContext context) {
    final currentData = isWeekly
        ? _prepareWeeklyData(
      widget.weeklyCaseGrowth,
    )
        : _prepareMonthlyData(
      widget.monthlyCaseGrowth,
    );

    debugPrint(
      currentData
          .map(
            (e) => "${e.date} : ${e.amount}",
      )
          .toList()
          .toString(),
    );

    final hasData = currentData.any(
          (e) => e.amount > 0,
    );

    final spots = _generateSpots(currentData);

    final maxX =
    spots.isEmpty ? 0.0 : spots.last.x;

    final maxY = _getMaxY(spots);

    final interval = maxY / 4;

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
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize:
                  MediaQuery.of(context)
                      .size
                      .width *
                      0.042,
                ),
              ),
              Row(
                children: [
                  _buildTab(
                    "أسبوعي",
                    true,
                  ),
                  const SizedBox(width: 8),
                  _buildTab(
                    "شهري",
                    false,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 260,
            child: !hasData
                ? const Center(
              child: Text(
                "لا توجد بيانات",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight:
                  FontWeight.w500,
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
                FlBorderData(
                  show: false,
                ),
                gridData:
                FlGridData(
                  show: true,
                  drawVerticalLine:
                  false,
                  horizontalInterval:
                  interval,
                  getDrawingHorizontalLine:
                      (value) {
                    return FlLine(
                      color: Colors
                          .grey
                          .shade300,
                      strokeWidth: 1.2,
                      dashArray: [
                        6,
                        4,
                      ],
                    );
                  },
                ),
                titlesData:
                FlTitlesData(
                  leftTitles:
                  AxisTitles(
                    sideTitles:
                    SideTitles(
                      showTitles:
                      true,
                      reservedSize:
                      50,
                      interval:
                      interval,
                      getTitlesWidget:
                          (
                          value,
                          meta,
                          ) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(
                            right:
                            8,
                          ),
                          child:
                          Text(
                            value
                                .toInt()
                                .toString(),
                            style:
                            const TextStyle(
                              fontSize:
                              11,
                              color:
                              Colors.grey,
                              fontWeight:
                              FontWeight.w500,
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
                      showTitles:
                      true,
                      reservedSize:
                      40,
                      interval:
                      1,
                      getTitlesWidget:
                          (
                          value,
                          meta,
                          ) {
                        final index =
                        value
                            .toInt();

                        if (index >=
                            0 &&
                            index <
                                currentData.length) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                              top:
                              10,
                            ),
                            child:
                            Text(
                              currentData[
                              index]
                                  .date,
                              style:
                              const TextStyle(
                                fontSize:
                                10,
                                fontWeight:
                                FontWeight.w500,
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
                      false,
                    ),
                  ),
                  topTitles:
                  const AxisTitles(
                    sideTitles:
                    SideTitles(
                      showTitles:
                      false,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness:
                    0.35,
                    preventCurveOverShooting:
                    true,
                    color:
                    const Color(
                      0xff2F674D,
                    ),
                    barWidth: 3,
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
                          radius:
                          4,
                          color:
                          const Color(
                            0xff2F674D,
                          ),
                          strokeWidth:
                          2,
                          strokeColor:
                          Colors.white,
                        );
                      },
                    ),
                    belowBarData:
                    BarAreaData(
                      show: true,
                      gradient:
                      LinearGradient(
                        begin:
                        Alignment.topCenter,
                        end:
                        Alignment.bottomCenter,
                        colors: [
                          const Color(
                            0xff2F674D,
                          ).withOpacity(
                            0.25,
                          ),
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
        duration: const Duration(
          milliseconds: 250,
        ),
        padding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(
            0xff2F674D,
          )
              : const Color(
            0xffE7E7E7,
          ),
          borderRadius:
          BorderRadius.circular(
            20,
          ),
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