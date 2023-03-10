import 'package:flutter/material.dart';
import 'package:example/utils/utils.dart';
import 'package:ui/ui.dart';

import 'chart_seller.dart';
import 'chart_store_analytic.dart';

List<DataSeller> _chartSeller = [
  DataSeller(0, 'Bridge for sale', 120, '#FDC309'),
  DataSeller(1, 'Consulta medica', 120, '#FF5200'),
  DataSeller(2, 'Test Product', 120, '#0B69FF'),
];

List<DataStoreAnalytic> _chartStoreAnalytic = [
  DataStoreAnalytic(0, '03 03 22', 30),
  DataStoreAnalytic(1, '03 04 22', 120),
  DataStoreAnalytic(2, '03 05 22', 10),
  DataStoreAnalytic(3, '03 06 22', 10),
  DataStoreAnalytic(4, '03 07 22', 10),
  DataStoreAnalytic(5, '03 08 22', 10),
  DataStoreAnalytic(6, '03 09 22', 10),
];

class HomeChart extends StatelessWidget {
  const HomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeViewSeller(
          title: 'Top Seller',
          chart: SizedBox(
            width: 100,
            height: 100,
            child: ChartSeller(
              data: _chartSeller,
            ),
          ),
          noteChart: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              DataSeller value = _chartSeller[index];
              return ChartLabel(
                color: ConvertData.fromHex(value.color) ?? Colors.black,
                name: value.name,
                isLargeText: true,
              );
            },
            separatorBuilder: (_, index) {
              return const SizedBox(height: 3);
            },
            itemCount: _chartSeller.length,
          ),
        ),
        const SizedBox(height: 30),
        HomeViewStoreAnalytic(
          title: 'Store Analytics',
          chart: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: ChartStoreAnalytic(data: _chartStoreAnalytic),
          ),
        ),
      ],
    );
  }
}
