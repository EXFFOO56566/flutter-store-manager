// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../bloc/order_chart_cubit.dart';

// View
import 'widgets/order_chart_body.dart';

class OrderChartPage extends StatelessWidget {
  const OrderChartPage({Key? key}) : super(key: key);
  static const routeName = '/orderChartPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderChartCubit>(
      create: (_) => OrderChartCubit(
        salesByDateRepository: SalesByDateRepository(context.read<HttpClient>()),
        token: context.read<AuthenticationBloc>().state.token,
      ),
      child: const OrderChartBody(),
    );
  }
}
