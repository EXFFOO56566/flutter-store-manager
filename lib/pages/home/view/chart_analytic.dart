// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:chart_analytic_repository/chart_analytic_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/home/chart_analytic/bloc/chart_analytic_cubit.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';

// View
import 'package:flutter_store_manager/pages/home/chart_analytic/view/chart_analytic_body.dart';

class ChartAnalytic extends StatelessWidget {
  const ChartAnalytic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartAnalyticCubit>(
      create: (_) => ChartAnalyticCubit(
          chartAnalyticRepository: ChartAnalyticRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          value: context.read<GlobalBloc>().state.stores['chart_analytic'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('chart_analytic', store))),
      child: const ChartAnalyticBody(),
    );
  }
}
