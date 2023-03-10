// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../bloc/order_chart_cubit.dart';

// View
import 'chart_legend.dart';
import 'line_title.dart';
import 'order_chart_info.dart';
import 'order_chart_tab.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

enum ChartType { gross, earn, refunds, tax, ship, orderCounts, withdrawal }

List<FilterChartOption> _optionTabs = [
  FilterChartOption.year,
  FilterChartOption.lastMonth,
  FilterChartOption.thisMonth,
  FilterChartOption.sevenDays,
  FilterChartOption.custom,
];

class OrderChartBody extends StatefulWidget {
  const OrderChartBody({Key? key}) : super(key: key);
  @override
  OrderChartBodyState createState() => OrderChartBodyState();
}

class OrderChartBodyState extends State<OrderChartBody> with AppbarMixin, SingleTickerProviderStateMixin {
  List<OrderChartMapped> listChartData = [];
  late OrderChartCubit cubit;

  double barWidth = 2;
  late double minX;
  late double maxX;

  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = 7;
    cubit = context.read<OrderChartCubit>();
    cubit.getChart();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: theme.canvasColor,
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
      ),
      child: DefaultTabController(
        key: const Key("tab_chart"),
        length: _optionTabs.length,
        initialIndex: 3,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                leading: leading(),
                title: Text(translate('chart:text_chart')),
                leadingWidth: 68,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(42),
                  child: OrderChartTab(optionTabs: _optionTabs),
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(_optionTabs.length, (index) {
                  return BlocConsumer<OrderChartCubit, OrderChartState>(
                    builder: (context, state) {
                      listChartData = getChartData(state.chartModel) ?? [];
                      return SingleChildScrollView(
                        child: OrderChartView(
                          info: OrderChartInfo(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            gross: ConvertData.stringToDouble(state.legendData?.grossSales),
                            earn: ConvertData.stringToDouble(state.legendData?.totalEarned),
                            refunds: ConvertData.stringToDouble(state.legendData?.totalRefund),
                            average: ConvertData.stringToDouble(state.legendData?.averageSales),
                            order: ConvertData.stringToDouble(state.legendData?.totalOrders),
                            items: ConvertData.stringToDouble(state.legendData?.totalItems),
                            tax: ConvertData.stringToDouble(state.legendData?.totalTax),
                            ship: ConvertData.stringToDouble(state.legendData?.totalShipping),
                            withdrawal: ConvertData.stringToDouble(state.legendData?.totalCommission),
                            currency: state.currency,
                            priceDecimal: state.priceDecimal,
                            isMonthly: (state.filterChartOption == FilterChartOption.year) ? true : false,
                          ),
                          titleChart: getNameChart(state.filterChartOption, translate),
                          chart: Column(
                            children: [
                              const SizedBox(height: 16),
                              AspectRatio(
                                aspectRatio: 1.7,
                                child: GestureDetector(
                                  key: const Key("chart_by_date"),
                                  onHorizontalDragUpdate: (dragUpdDet) {
                                    setState(() {
                                      double primDelta = dragUpdDet.primaryDelta ?? 0.0;
                                      if (primDelta != 0) {
                                        if (primDelta.isNegative) {
                                          if (maxX < (listChartData.length + 1)) {
                                            minX += listChartData.length * 0.005;
                                            maxX += listChartData.length * 0.005;
                                          }
                                        } else {
                                          if (minX > 0) {
                                            minX -= listChartData.length * 0.005;
                                            maxX -= listChartData.length * 0.005;
                                          }
                                        }
                                      }
                                    });
                                  },
                                  child: LineChart(
                                    LineChartData(
                                      minX: minX,
                                      maxX: maxX,
                                      minY: 0,
                                      maxY: (listChartData.isNotEmpty)
                                          ? double.parse(OrderChartMapped.max.round().toString())
                                          : 5000,
                                      titlesData: LineTitle.getTitleData(
                                          listData: listChartData,
                                          style: theme.textTheme.overline
                                              ?.copyWith(color: theme.textTheme.caption?.color)),
                                      clipData: FlClipData.horizontal(),
                                      gridData: FlGridData(
                                        getDrawingHorizontalLine: (value) {
                                          return FlLine(
                                            color: theme.dividerColor,
                                            strokeWidth: 1,
                                          );
                                        },
                                        getDrawingVerticalLine: (value) {
                                          return FlLine(
                                            color: theme.dividerColor,
                                            strokeWidth: 1,
                                          );
                                        },
                                      ),
                                      lineTouchData: LineTouchData(
                                        enabled: true,
                                        touchTooltipData: LineTouchTooltipData(
                                          tooltipBgColor: theme.dividerColor,
                                          fitInsideVertically: true,
                                        ),
                                      ),
                                      borderData: FlBorderData(show: false),
                                      lineBarsData: [
                                        //order counts
                                        LineChartBarData(
                                          colors: ColorBlock.listChartColor[5],
                                          spots: generateSpots(chartType: ChartType.orderCounts),
                                          isCurved: true,
                                          preventCurveOverShooting: true,
                                          preventCurveOvershootingThreshold: 15,
                                          curveSmoothness: 0.4,
                                          barWidth: barWidth,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              colors:
                                                  ColorBlock.listChartColor[5].map((e) => e.withOpacity(0.3)).toList()),
                                        ),
                                        //ship
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[4],
                                            spots: generateSpots(chartType: ChartType.ship),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[4]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                        //tax
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[3],
                                            spots: generateSpots(chartType: ChartType.tax),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[3]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                        //withdrawal
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[6],
                                            spots: generateSpots(chartType: ChartType.withdrawal),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[6]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                        //refunds
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[2],
                                            spots: generateSpots(chartType: ChartType.refunds),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[2]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                        //earn
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[1],
                                            spots: generateSpots(chartType: ChartType.earn),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[1]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                        //gross
                                        LineChartBarData(
                                            colors: ColorBlock.listChartColor[0],
                                            spots: generateSpots(chartType: ChartType.gross),
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                            preventCurveOvershootingThreshold: 15,
                                            curveSmoothness: 0.4,
                                            barWidth: barWidth,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                colors: ColorBlock.listChartColor[0]
                                                    .map((e) => e.withOpacity(0.3))
                                                    .toList())),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 27),
                              buildLegendChartOrder(translate),
                            ],
                          ),
                          padding: const EdgeInsets.only(top: 24, bottom: 39),
                          marginViewChart: const EdgeInsets.symmetric(horizontal: 25),
                        ),
                      );
                    },
                    listenWhen: (previous, current) => previous.chartModel != current.chartModel,
                    listener: (context, state) {
                      setState(() {
                        minX = 0.9;
                        maxX = 7;
                      });
                    },
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }

  String getNameChart(FilterChartOption option, TranslateType translate) {
    late String text;

    switch (option) {
      case FilterChartOption.lastMonth:
        text = translate('chart:text_sales_report_by_last_month');
        break;
      case FilterChartOption.thisMonth:
        text = translate('chart:text_sales_report_by_this_month');
        break;
      case FilterChartOption.sevenDays:
        text = translate('chart:text_sales_report_by_seven_day');
        break;
      case FilterChartOption.custom:
        text = translate('chart:text_sales_report_by_custom');
        break;
      default:
        text = translate('chart:text_sales_report_by_year');
    }
    return text;
  }

  List<OrderChartMapped>? getChartData(dynamic data) {
    return OrderChartMapped.generateChartMapped(model: data);
  }

  generateSpots({required ChartType chartType}) {
    switch (chartType) {
      case ChartType.gross:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].grossSale ?? 0));
        }
        return list;
      case ChartType.withdrawal:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].withdrawal ?? 0));
        }
        return list;
      case ChartType.earn:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].earning ?? 0));
        }
        return list;
      case ChartType.refunds:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].refunds ?? 0));
        }
        return list;
      case ChartType.tax:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].taxAmounts ?? 0));
        }
        return list;
      case ChartType.ship:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].shippingAmounts ?? 0));
        }
        return list;
      case ChartType.orderCounts:
        List<FlSpot> list = [];
        for (int i = 0; i < listChartData.length; i++) {
          list.add(FlSpot(double.parse((i + 1).toString()), listChartData[i].orderCount ?? 0));
        }
        return list;
      default:
    }
  }
}
