// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

// Bloc
import 'package:flutter_store_manager/pages/home/chart_sales/bloc/chart_sales_cubit.dart';

// View
import 'package:flutter_store_manager/pages/home/chart_sales/view/widgets/bar_title.dart';
import 'package:flutter_store_manager/themes.dart';

class ChartSalesHomeBody extends StatefulWidget {
  const ChartSalesHomeBody({Key? key}) : super(key: key);
  @override
  ChartSalesHomeBodyState createState() => ChartSalesHomeBodyState();
}

class ChartSalesHomeBodyState extends State<ChartSalesHomeBody> {
  List<OrderChartMapped> listChartData = [];
  late ChartSalesHomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChartSalesHomeCubit>();
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

    return Column(
      children: [
        _buildHeadChart(theme, translate),
        const SizedBox(height: 25),
        BlocBuilder<ChartSalesHomeCubit, ChartSalesHomeState>(
          builder: (context, state) {
            listChartData = getChartData(state.chartModel) ?? [];
            Widget child = listChartData.isNotEmpty
                ? BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      minY: 0,
                      maxY: OrderChartMapped.maxHomeChart > 0 ? OrderChartMapped.maxHomeChart : 1000,
                      groupsSpace: 25,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          fitInsideVertically: true,
                          tooltipBgColor: theme.dividerColor,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            String grossSale = currency_format.formatCurrency(
                              price: '${group.barRods[1].toY}',
                              symbol: currency_format.getSymbol(state.currency ?? "USD"),
                              decimalDigits: ConvertData.stringToInt(state.priceDecimal),
                              context: context,
                            );
                            String earnSale = currency_format.formatCurrency(
                              price: '${group.barRods[2].toY}',
                              symbol: currency_format.getSymbol(state.currency ?? "USD"),
                              decimalDigits: ConvertData.stringToInt(state.priceDecimal),
                              context: context,
                            );
                            return BarTooltipItem(
                              "",
                              const TextStyle(
                                color: Colors.pink,
                                fontSize: 0,
                              ),
                              children: [
                                TextSpan(
                                  text: "$grossSale\n",
                                  style: theme.textTheme.bodyText2?.copyWith(color: theme.primaryColorLight),
                                ),
                                TextSpan(
                                  text: earnSale,
                                  style: theme.textTheme.bodyText2?.copyWith(color: theme.primaryColor),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: BarTitles.getLeftTitles(
                          listChartData: listChartData,
                          textStyle: theme.textTheme.caption?.copyWith(fontSize: 10),
                        ),
                        bottomTitles: BarTitles.getBottomTitles(
                          listChartData: listChartData,
                          textStyle: theme.textTheme.overline,
                        ),
                        topTitles: BarTitles.getHiddenTitles(),
                        rightTitles: BarTitles.getHiddenTitles(),
                      ),
                      barGroups: generateBarChart(listChartData: listChartData, theme: theme),
                    ),
                    swapAnimationDuration: Duration.zero,
                  )
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      minY: 0,
                      maxY: 1000,
                      groupsSpace: 25,
                      barTouchData: BarTouchData(enabled: false),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: BarTitles.getLeftTitles(
                          listChartData: listChartData,
                          textStyle: theme.textTheme.caption?.copyWith(fontSize: 10),
                          getTitles: (_) => '',
                        ),
                        bottomTitles: BarTitles.getBottomTitles(
                          listChartData: listChartData,
                          textStyle: theme.textTheme.overline,
                        ),
                        topTitles: BarTitles.getHiddenTitles(),
                        rightTitles: BarTitles.getHiddenTitles(),
                      ),
                      barGroups: generateBarChart(listChartData: listChartData, theme: theme),
                    ),
                    swapAnimationDuration: Duration.zero,
                  );
            return AspectRatio(
              aspectRatio: 1.5,
              child: child,
            );
          },
        ),
      ],
    );
  }

  _buildHeadChart(ThemeData theme, TranslateType translate) {
    return SizedBox(
      // height: 100,
      child: Row(
        children: [
          Expanded(
            child: LabelInput(
              title: translate('home:text_week'),
              isLarge: true,
              padding: EdgeInsets.zero,
            ),
          ),
          ChartLabel(
            color: theme.primaryColor,
            name: translate('home:text_earning'),
            isExpand: false,
          ),
          const SizedBox(width: 20),
          ChartLabel(
            color: theme.primaryColorLight,
            name: translate('home:text_gross_sale'),
            isExpand: false,
          ),
        ],
      ),
    );
  }

  List<OrderChartMapped>? getChartData(dynamic data) {
    return OrderChartMapped.generateChartMapped(model: data);
  }

  generateBarChart({required List<OrderChartMapped> listChartData, required ThemeData theme}) {
    List<BarChartGroupData> list = [];
    if (listChartData.isNotEmpty) {
      for (int i = 0; i < listChartData.length; i++) {
        list.add(
          BarChartGroupData(
            x: i,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: OrderChartMapped.maxHomeChart > 0 ? OrderChartMapped.maxHomeChart : 1000,
                width: 11,
                colors: [theme.primaryColor.withOpacity(0.2)],
                borderRadius: BorderRadius.circular(10),
              ),
              BarChartRodData(
                fromY: 0,
                toY: listChartData[i].grossSale ?? 5,
                width: 11,
                colors: [theme.primaryColorLight],
                borderRadius: BorderRadius.circular(10),
              ),
              BarChartRodData(
                toY: listChartData[i].earning ?? 5,
                width: 11,
                colors: [theme.primaryColor],
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
        );
      }
    } else {
      for (int i = 0; i < 7; i++) {
        list.add(
          BarChartGroupData(
            x: i,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 1000,
                width: 11,
                colors: [theme.primaryColor.withOpacity(0.2)],
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        );
      }
    }
    return list;
  }
}
