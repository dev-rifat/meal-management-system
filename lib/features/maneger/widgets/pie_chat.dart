import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData {
  final String label;
  final double percentage;
  final Color color;

  ChartData({
    required this.label,
    required this.percentage,
    required this.color,
  });
}

class SummaryChart extends StatelessWidget {
  final List<ChartData> data;

  const SummaryChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: Row(
              children: [
                const SizedBox(width: 14),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 30,
                      sections: data.map((e) {
                        return PieChartSectionData(
                          value: e.percentage,
                          color: e.color,
                          title: '${e.percentage.toStringAsFixed(0)}%',
                          radius: 46,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                // Wrap inside Expanded to avoid overflow
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: data
                          .map((e) => chartLegend(e.label, e.color))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chartLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(backgroundColor: color, radius: 5),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
