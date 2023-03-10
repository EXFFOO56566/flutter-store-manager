import 'package:appcheap_flutter_core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:order_repository/order_repository.dart';

import '../cubit/order_note_cubit.dart';
import 'order_note_body.dart';

class OrderNoteView extends StatelessWidget {
  final int orderId;
  const OrderNoteView({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider(
        create: (context) {
          return OrderNoteCubit(
            orderRepository: OrderRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
          );
        },
        child: OrderNoteBody(orderId: orderId),
      ),
    );
  }
}
