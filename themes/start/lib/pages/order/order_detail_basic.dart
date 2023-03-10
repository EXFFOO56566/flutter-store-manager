import 'package:flutter/material.dart';

class OrderDetailBasic extends StatelessWidget {
  final Widget icon;
  final Widget orderId;
  final Widget status;
  final Widget dateTime;

  const OrderDetailBasic({
    Key? key,
    required this.icon,
    required this.orderId,
    required this.status,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(
              child: orderId,
            ),
            const SizedBox(width: 12),
            status,
          ],
        ),
        const SizedBox(height: 12),
        dateTime,
      ],
    );
  }
}
