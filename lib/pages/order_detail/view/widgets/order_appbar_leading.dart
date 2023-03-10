import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/order_detail/bloc/order_detail_cubit.dart';
import 'package:flutter_store_manager/themes.dart';

class OrderAppbarLeading extends StatelessWidget with AppbarMixin {
  const OrderAppbarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      buildWhen: (previous, current) => previous.updateData != current.updateData,
      builder: (context, state) {
        return leading(
          onPressed: () {
            Navigator.pop(context, state.updateData);
          },
        );
      },
    );
  }
}
