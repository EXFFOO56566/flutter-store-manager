import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class ChatItemUi extends StatelessWidget {
  final Widget avatar;
  final Widget name;
  final Widget message;
  final Widget time;
  final Widget? count;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const ChatItemUi({
    Key? key,
    required this.avatar,
    required this.name,
    required this.message,
    required this.time,
    this.count,
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
            avatar,
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [name],
                        ),
                      ),
                      const SizedBox(width: 21),
                      time
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [message],
                        ),
                      ),
                      if (count != null) ...[
                        const SizedBox(width: 29),
                        count ?? Container(),
                      ]
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
