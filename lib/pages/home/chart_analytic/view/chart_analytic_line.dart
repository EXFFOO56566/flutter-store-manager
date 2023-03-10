import 'package:chart_analytic_repository/chart_analytic_repository.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ChartAnalyticLine extends StatelessWidget {
  final List<AnalyticData> data;

  const ChartAnalyticLine({
    Key? key,
    required this.data,
  }) : super(key: key);

  double getMaxCount(List<AnalyticData> chartData) {
    if (chartData.isNotEmpty) {
      AnalyticData value = chartData.reduce((a, b) {
        return a.count > b.count ? a : b;
      });
      int countMax = value.count;
      if (countMax > 0) {
        return (5 * (countMax / 5).ceil()).toDouble();
      }
    }
    return 500;
  }

  List<FlSpot> getSpots(List<AnalyticData> chartData, double maxCount) {
    List<FlSpot> value = [];
    for (int i = 0; i < chartData.length; i++) {
      final AnalyticData item = chartData[i];
      value.add(FlSpot(i.toDouble(), (item.count * 5) / maxCount));
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double maxX = data.isNotEmpty ? data.length - 1 : 6;
    double maxCount = getMaxCount(data);
    List<FlSpot> spots = getSpots(data, maxCount);

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.colorScheme.surface,
                strokeWidth: 1,
              );
            },
          ),
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchSpotThreshold: 10,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: theme.primaryColor,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                List<LineTooltipItem> lineBarSpot = touchedSpots.map(
                  (e) {
                    int count = e.spotIndex < data.length ? data[e.spotIndex].count : 0;
                    return LineTooltipItem(
                      '$count',
                      theme.textTheme.caption!.copyWith(color: Colors.white),
                    );
                  },
                ).toList();

                return lineBarSpot;
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTextStyles: (context, value) => theme.textTheme.overline,
              getTitles: (value) {
                int visit = value.toInt();
                if (visit < data.length) {
                  DateTime date = DateFormat('MM d yy').parse(data[visit].name);
                  return DateFormat('d\nEE').format(date);
                }
                return '...';
              },
              margin: 12,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTextStyles: (context, value) =>
                  theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
              getTitles: (value) {
                if (spots.isEmpty) {
                  return '';
                }
                if (value == 0) {
                  return '0';
                }
                if (value.toInt() == 5) {
                  return '';
                }
                return '${maxCount * value.toInt() ~/ 5}';
              },
              reservedSize: 32,
              margin: 15,
              textAlign: TextAlign.end,
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: maxX,
          minY: 0,
          maxY: 5,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              preventCurveOverShooting: true,
              preventCurveOvershootingThreshold: 15,
              colors: [theme.primaryColor],
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: [theme.primaryColorLight.withOpacity(0.2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
