import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:example/utils/utils.dart';

class ChartSeller extends StatelessWidget {
  final List<DataSeller> data;
  const ChartSeller({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 100,
      height: 100,
      child: PieChart(
        PieChartData(
          startDegreeOffset: 270,
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(data, theme),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<DataSeller> data, ThemeData theme) {
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
        DataSeller item = data[i];
        return PieChartSectionData(
          color: ConvertData.fromHex(item.color),
          value: item.sales.toDouble(),
          title: '',
          radius: 50,
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide.none,
        );
      },
    );
  }
}

class DataSeller {
  final int id;
  final String name;
  final int sales;
  final String color;

  DataSeller(this.id, this.name, this.sales, this.color);
}
