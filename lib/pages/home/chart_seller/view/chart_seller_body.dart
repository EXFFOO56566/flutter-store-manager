import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/home/chart_seller/bloc/chart_seller_cubit.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import 'chart_seller_pie.dart';

List<Color> _colors = const [
  Color(0xFFFDC309),
  Color(0xFFFF5200),
  Color(0xFF0B69FF),
  Color(0xFF56CCF2),
  Color(0xFF005082),
];

class ChartSellerBody extends StatefulWidget {
  const ChartSellerBody({Key? key}) : super(key: key);

  @override
  ChartSellerBodyState createState() => ChartSellerBodyState();
}

class ChartSellerBodyState extends State<ChartSellerBody> {
  late ChartSellerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChartSellerCubit>();
    cubit.getSeller();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  List<SellerData> getChartData(ChartSellerState state) {
    if (state.data?.isNotEmpty == true) {
      List<SellerData> data = state.data!.map((e) {
        int i = state.data!.indexOf(e);
        return SellerData(
          name: e.name ?? '',
          count: e.count,
          color: i >= 0 && i < 5 ? _colors[i] : ConvertData.randomColor(),
        );
      }).toList();
      return data;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartSellerCubit, ChartSellerState>(builder: (context, state) {
      List<SellerData> data = getChartData(state);
      return HomeViewSeller(
        title: AppLocalizations.of(context)!.translate('home:text_sale_product'),
        chart: ChartSellerPie(data: data),
        noteChart: data.isNotEmpty == true
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  SellerData value = data[index];
                  return ChartLabel(
                    color: value.color,
                    name: value.name,
                    isLargeText: true,
                  );
                },
                separatorBuilder: (_, index) {
                  return const SizedBox(height: 3);
                },
                itemCount: data.length,
              )
            : Container(),
      );
    });
  }
}
