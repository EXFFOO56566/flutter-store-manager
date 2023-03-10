import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class OrderItemUi extends StatelessWidget {
  final Widget icon;
  final Widget orderId;
  final Widget status;
  final Widget dateTimeUser;
  final Widget info;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const OrderItemUi({
    Key? key,
    required this.icon,
    required this.orderId,
    required this.status,
    required this.dateTimeUser,
    required this.info,
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
                      const SizedBox(width: 12),
                      status,
                    ],
                  ),
                  const SizedBox(height: 13),
                  dateTimeUser,
                  const SizedBox(height: 6),
                  info,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
