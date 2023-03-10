import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class DeliveryItemUi extends StatelessWidget {
  final Widget icon;
  final Widget orderId;
  final Widget status;
  final Widget paymentType;
  final Widget product;
  final Widget? remaining;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const DeliveryItemUi({
    Key? key,
    required this.icon,
    required this.orderId,
    required this.status,
    required this.paymentType,
    required this.product,
    this.remaining,
    this.dividerColor,
    this.indentDivider,
    this.endIndentDivider,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: BoxDividerUi(
        padding: padding,
        color: dividerColor,
        indentDivider: indentDivider,
        endIndentDivider: endIndentDivider,
        heightDivider: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [orderId],
                        ),
                      ),
                      if (remaining != null) ...[
                        const SizedBox(width: 12),
                        remaining ?? Container(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 7),
                  product,
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [paymentType],
                        ),
                      ),
                      const SizedBox(width: 12),
                      status,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
