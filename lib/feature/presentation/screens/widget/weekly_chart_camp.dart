import 'package:aoun/feature/data/models/growth_camp_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyCampChart extends StatefulWidget {
  final String title;
  final List<GrowthCampModel> weeklyCampGrowth;
  final List<GrowthCampModel> monthlyCampGrowth;

  const WeeklyCampChart({
    super.key,
    required this.title,
    required this.weeklyCampGrowth,
    required this.monthlyCampGrowth,
  });

  @override
  State<WeeklyCampChart> createState() => _WeeklyCampChartState();
}

class _WeeklyCampChartState extends State<WeeklyCampChart> {
  bool isWeekly = true;

  // 🔥 FIX 1: normalize labels (important)
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM').format(date);
  }

  // 🔥 FIX 2: WEEKLY (safe matching)
  List<GrowthCampModel> _prepareWeeklyData(
      List<GrowthCampModel> apiData,
      ) {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final day = now.subtract(Duration(days: 6 - index));

      final matched = apiData.where((e) {
        final parsed = DateFormat('dd/MM').parse(e.label);
        return parsed.day == day.day && parsed.month == day.month;
      });

      return matched.isNotEmpty
          ? matched.first
          : GrowthCampModel(
        label: DateFormat('dd/MM').format(day),
        amount: 0,
      );
    });
  }
  // 🔥 FIX 3: MONTHLY (correct parsing)
  List<GrowthCampModel> _prepareMonthlyData(
      List<GrowthCampModel> apiData,
      ) {
    final now = DateTime.now();

    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return List.generate(daysInMonth, (index) {
      final day = index + 1;

      final matched = apiData.where((e) {
        final parts = e.label.split('/');
        if (parts.length < 2) return false;

        return int.tryParse(parts[0]) == day;
      });

      return matched.isNotEmpty
          ? matched.first
          : GrowthCampModel(
        label: day.toString().padLeft(2, '0'),
        amount: 0,
      );
    });
  }
  // 🔥 FIX 4: spots
  List<FlSpot> _generateSpots(List<GrowthCampModel> data) {
    return List.generate(
      data.length,
          (index) => FlSpot(
        index.toDouble(),
        data[index].amount,
      ),
    );
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 100;

    final max = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    return max == 0 ? 100 : max + (max * 0.3);
  }

  @override
  Widget build(BuildContext context) {
    final currentData = isWeekly
        ? _prepareWeeklyData(widget.weeklyCampGrowth)
        : _prepareMonthlyData(widget.monthlyCampGrowth);

    final hasData = currentData.any((e) => e.amount > 0);
    final spots = _generateSpots(currentData);

    final maxX = spots.isEmpty ? 0.0 : spots.last.x;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE + TABS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.width * 0.042,
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
            child: !hasData
                ? const Center(
              child: Text(
                "لا توجد بيانات",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : LineChart(
              LineChartData(
                minX: 0,
                maxX: maxX,
                minY: 0,
                maxY: maxY,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: interval,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString());
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < currentData.length) {
                          return Text(currentData[i].label);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: const Color(0xff2F674D),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff2F674D).withOpacity(0.25),
                          Colors.transparent,
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

  Widget _buildTab(String text, bool weekly) {
    final isSelected = isWeekly == weekly;

    return GestureDetector(
      onTap: () => setState(() => isWeekly = weekly),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
          isSelected ? const Color(0xff2F674D) : const Color(0xffE7E7E7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}