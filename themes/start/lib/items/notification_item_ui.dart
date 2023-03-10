import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class NotificationItemUi extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget status;
  final Widget dateTime;
  final Widget? type;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const NotificationItemUi({
    Key? key,
    required this.icon,
    required this.title,
    required this.status,
    required this.dateTime,
    this.type,
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
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: icon,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: dateTime),
                      if (type != null) ...[
                        const SizedBox(width: 12),
                        type ?? Container(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  title,
                  const SizedBox(height: 11),
                  status,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
