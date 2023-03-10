// App core
import 'package:appcheap_flutter_core/di/di.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/stores/global/global_store.dart';
import '../bloc/order_cubit.dart';

// View
import 'widgets/order_body.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (_) => OrderCubit(
          orderRepository: OrderRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          value: context.read<GlobalBloc>().state.stores['orders'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('orders', store))),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: const OrderBody(),
      ),
    );
  }
}
