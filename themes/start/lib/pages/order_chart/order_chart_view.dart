import 'package:flutter/material.dart';
import 'package:ui/pages/home/home_view_store_analytic.dart';

class OrderChartView extends StatelessWidget {
  final Widget info;
  final String titleChart;
  final Widget chart;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? marginViewChart;

  const OrderChartView({
    Key? key,
    required this.info,
    required this.titleChart,
    required this.chart,
    this.padding,
    this.marginViewChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          info,
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: marginViewChart,
            child: HomeViewStoreAnalytic(
              title: titleChart,
              chart: chart,
            ),
          )
        ],
      ),
    );
  }
}
