import 'package:flutter/material.dart';

class OrderDetailContent extends StatelessWidget {
  final Widget orderBasic;
  final Widget billing;
  final Widget shipping;
  final Widget product;
  final Widget status;
  final Widget buttonBottom;
  final Widget note;
  const OrderDetailContent({
    Key? key,
    required this.orderBasic,
    required this.billing,
    required this.shipping,
    required this.product,
    required this.status,
    required this.buttonBottom,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        orderBasic,
        const SizedBox(height: 20),
        billing,
        const SizedBox(height: 30),
        shipping,
        const SizedBox(height: 30),
        product,
        const SizedBox(height: 30),
        note,
        const SizedBox(height: 30),
        status,
        const SizedBox(height: 30),
        buttonBottom,
      ],
    );
  }
}
