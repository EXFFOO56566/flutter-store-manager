import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartSellerPie extends StatefulWidget {
  final List<SellerData> data;

  const ChartSellerPie({Key? key, required this.data}) : super(key: key);

  @override
  ChatSellerPie createState() => ChatSellerPie();
}

class ChatSellerPie extends State<ChartSellerPie> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 100,
      height: 100,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (widget.data.isNotEmpty) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  _touchedIndex = -1;
                  return;
                }
                _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            }
          }),
          startDegreeOffset: 270,
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(widget.data, theme),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<SellerData> data, ThemeData theme) {
    if (data.isEmpty) {
      return [
        PieChartSectionData(
          color: theme.dividerColor,
          value: 1,
          title: '',
          radius: 50,
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide.none,
        )
      ];
    }
    return List.generate(
      data.length,
      (i) {
        SellerData item = data[i];
        final isTouched = i == _touchedIndex;
        return PieChartSectionData(
          color: item.color,
          value: item.count.toDouble(),
          title: '',
          radius: isTouched ? 60 : 50,
          badgeWidget: isTouched
              ? Text(
                  '${item.count}',
                  style: theme.textTheme.subtitle1?.copyWith(color: Colors.white),
                )
              : null,
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide.none,
        );
      },
    );
  }
}

class SellerData {
  final String name;
  final int count;
  final Color color;
  SellerData({
    required this.name,
    required this.count,
    required this.color,
  });
}
