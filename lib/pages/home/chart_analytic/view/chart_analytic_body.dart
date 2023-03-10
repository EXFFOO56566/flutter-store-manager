import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/home/chart_analytic/bloc/chart_analytic_cubit.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

import 'chart_analytic_line.dart';

class ChartAnalyticBody extends StatefulWidget {
  const ChartAnalyticBody({Key? key}) : super(key: key);

  @override
  ChartAnalyticBodyState createState() => ChartAnalyticBodyState();
}

class ChartAnalyticBodyState extends State<ChartAnalyticBody> {
  late ChartAnalyticCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChartAnalyticCubit>();
    cubit.getAnalytic();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartAnalyticCubit, ChartAnalyticState>(builder: (context, state) {
      return HomeViewStoreAnalytic(
        title: AppLocalizations.of(context)!.translate('home:text_analytic'),
        chart: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: ChartAnalyticLine(
            data: state.data ?? [],
          ),
        ),
      );
    });
  }
}
