// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

// Bloc
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/home/chart_sales/bloc/chart_sales_cubit.dart';

// View
import 'package:flutter_store_manager/pages/home/chart_sales/view/chart_sales_body.dart';

class ChartSalesHome extends StatelessWidget {
  const ChartSalesHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartSalesHomeCubit>(
      create: (_) => ChartSalesHomeCubit(
          salesByDateRepository: SalesByDateRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          value: context.read<GlobalBloc>().state.stores['chart_sales'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('chart_sales', store))),
      child: const ChartSalesHomeBody(),
    );
  }
}
