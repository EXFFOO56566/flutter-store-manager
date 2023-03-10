import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class EnquiryBoardItemUi extends StatelessWidget {
  final Widget icon;
  final Widget name;
  final Widget reply;
  final Widget dateTime;
  final Widget enquiry;
  final bool? isReply;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const EnquiryBoardItemUi({
    Key? key,
    required this.icon,
    required this.name,
    required this.reply,
    required this.dateTime,
    required this.enquiry,
    this.onTap,
    this.padding,
    this.isReply = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: BoxDividerUi(
        padding: padding,
        color: theme.dividerColor,
        indentDivider: isReply == true ? 0 : 80,
        endIndentDivider: 0,
        heightDivider: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 20),
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
                          children: [name],
                        ),
                      ),
                      const SizedBox(width: 12),
                      reply,
                    ],
                  ),
                  const SizedBox(height: 7),
                  dateTime,
                  const SizedBox(height: 7),
                  enquiry,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
