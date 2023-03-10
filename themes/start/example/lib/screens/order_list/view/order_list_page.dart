import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  static const routeName = '/order_list';
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Order list'),
      ),
    );
  }
}
