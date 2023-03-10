import 'package:example/blocs/blocs.dart';
import 'package:example/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../widgets/report_time_view.dart';

class ReportPage extends StatefulWidget {
  static const routeName = '/report';

  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with AppbarMixin {
  @override
  void didChangeDependencies() {
    context.read<ReportCubit>().getReport();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: 'All Reports'),
      backgroundColor: theme.canvasColor,
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          ReportModel data = state.data;
          List<Map<String, dynamic>> listData = [
            {
              'name': 'Last 7 Days',
              'data': data.data.week,
            },
            {
              'name': 'This Month',
              'data': data.data.month,
            },
            {
              'name': 'Last Month',
              'data': data.data.lastMonth,
            },
            {
              'name': 'Year',
              'data': data.data.year,
            },
          ];
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
            itemBuilder: (_, int index) {
              Map<String, dynamic> item = listData[index];
              return ReportTimeView(title: item['name'], data: item['data']);
            },
            separatorBuilder: (_, int index) {
              return const SizedBox(height: 42);
            },
            itemCount: listData.length,
          );
        },
      ),
    );
  }
}
