// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:sale_product_repository/sale_product_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';
import 'package:flutter_store_manager/pages/home/chart_seller/bloc/chart_seller_cubit.dart';

// View
import 'package:flutter_store_manager/pages/home/chart_seller/view/chart_seller_body.dart';

class ChartSeller extends StatelessWidget {
  const ChartSeller({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartSellerCubit>(
      create: (_) => ChartSellerCubit(
          saleProductRepository: SaleProductRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          value: context.read<GlobalBloc>().state.stores['chart_seller'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('chart_seller', store))),
      child: const ChartSellerBody(),
    );
  }
}
