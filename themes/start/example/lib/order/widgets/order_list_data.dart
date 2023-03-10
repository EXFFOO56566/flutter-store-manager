import 'package:flutter/material.dart';

import '../../widgets/order_item.dart';

class OrderListData extends StatelessWidget {
  const OrderListData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      child: Column(
        children: List.generate(
          10,
          (index) => const OrderItem(padding: EdgeInsets.only(top: 17, bottom: 15)),
        ),
      ),
    );
  }
}
