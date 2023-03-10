// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/cupertino.dart';

// Packages & Dependencies or Helper function
import 'package:fl_chart/fl_chart.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

class LineTitle {
  static getTitleData({required List<OrderChartMapped> listData, TextStyle? style}) => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            margin: 20,
            getTextStyles: (BuildContext context, value) => style,
            getTitles: (value) {
              if (listData.isNotEmpty) {
                if (value % 1 == 0) {
                  if (value > 0 && value <= listData.length) {
                    String num = (value - 1).toStringAsFixed(0);
                    return formatChartDate(date: listData[int.parse(num)].day);
                  } else {
                    return "";
                  }
                } else {
                  return "";
                }
              } else {
                return "...";
              }
            }),
        topTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          margin: 8,
          showTitles: true,
          reservedSize: 40,
          getTextStyles: (BuildContext context, value) => style,
        ),
        rightTitles: SideTitles(showTitles: false),
      );
}
