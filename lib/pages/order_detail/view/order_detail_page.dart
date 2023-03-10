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
import 'package:flutter_store_manager/pages/order_detail/bloc/order_detail_cubit.dart';

// View
import 'package:flutter_store_manager/themes.dart';
import 'widgets/order_detail_body.dart';

class OrdersDetailPage extends StatelessWidget with AppbarMixin {
  const OrdersDetailPage({Key? key}) : super(key: key);
  static const routeName = '/order_detail';

  @override
  Widget build(BuildContext context) {
    ///order
    dynamic data = ModalRoute.of(context)!.settings.arguments;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider(
        create: (context) {
          return OrderDetailCubit(
            orderRepository: OrderRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
          );
        },
        child: OrderDetailBody(orderData: data as Map),
      ),
    );
  }
}
