import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/top_charity_model.dart';
import '../../state_management/cubit/top_charities_cubit.dart';

class DataChart extends StatelessWidget {
  const DataChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopCharitiesCubit, TopCharitiesState>(
      builder: (context, state) {
        if (state is TopCharitiesLoading) {
          return const SizedBox(
            height: 450,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is TopCharitiesError) {
          return SizedBox(
            height: 450,
            child: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is TopCharitiesSuccess) {
          return _buildChart(state.charities);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildChart(List<TopCharityModel> charities) {
    final double maxValue = charities.isEmpty
        ? 100.0
        : charities
        .map((e) => e.total.toDouble())
        .reduce((a, b) => a > b ? a : b) +
        5000.0;

    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الإجمالي',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: SizedBox(
              width: charities.length * 140,
              child: BarChart(
                BarChartData(
                  maxY: maxValue,
                  minY: 0,
                  alignment: BarChartAlignment.spaceAround,

                  /// Tooltip فوق الأعمدة
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.transparent,
                      tooltipPadding: EdgeInsets.zero,
                      tooltipMargin: 8,
                      getTooltipItem:
                          (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          rod.toY.toInt().toString(),
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),

                  /// أسماء الجمعيات
                  titlesData: FlTitlesData(
                    show: true,

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= charities.length) {
                            return const SizedBox();
                          }

                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 10,
                            child: SizedBox(
                              width: 80,
                              child: Text(
                                charities[value.toInt()].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 55,
                        interval: maxValue / 5,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),
                          );
                        },
                      ),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  /// خطوط الخلفية
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxValue / 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),

                  borderData: FlBorderData(show: false),

                  /// الأعمدة
                  barGroups:
                  charities.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      showingTooltipIndicators: [0],
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.total.toDouble(),
                          width: 40,
                          color: const Color(0xFF6DA28D),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}