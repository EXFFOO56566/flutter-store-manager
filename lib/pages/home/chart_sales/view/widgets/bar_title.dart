// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:fl_chart/fl_chart.dart';

// Flutter library
import 'package:flutter/material.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

// Constants
import 'package:flutter_store_manager/constants/strings.dart';

class BarTitles {
  static SideTitles getBottomTitles({required List<OrderChartMapped> listChartData, TextStyle? textStyle}) =>
      SideTitles(
        showTitles: true,
        margin: 15,
        reservedSize: 40,
        getTextStyles: (_, double value) {
          return textStyle ?? const TextStyle();
        },
        getTitles: (double id) {
          if (listChartData.isNotEmpty) {
            return formatDateToDayOfWeek(date: listChartData[id.toInt()].day);
          } else {
            return Strings.dayOfWeek[id.toInt()];
          }
        },
      );
  static SideTitles getLeftTitles({
    required List<OrderChartMapped> listChartData,
    TextStyle? textStyle,
    GetTitleFunction? getTitles,
  }) =>
      SideTitles(
        showTitles: true,
        margin: 14,
        getTextStyles: (_, double value) {
          return textStyle ?? const TextStyle();
        },
        getTitles: getTitles,
        reservedSize: 32,
        textAlign: TextAlign.end,
      );
  static SideTitles getHiddenTitles() => SideTitles(
        showTitles: false,
      );
}
