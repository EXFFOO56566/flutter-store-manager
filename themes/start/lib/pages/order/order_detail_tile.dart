import 'package:flutter/material.dart';

enum TextSize { bodyText2, subtitle2, overline }

class OrderDetailTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextSize textSize;
  final bool titleSubColor;

  const OrderDetailTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.textSize = TextSize.bodyText2,
    this.titleSubColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? style;
    switch (textSize) {
      case TextSize.overline:
        style = theme.textTheme.overline;
        break;
      case TextSize.subtitle2:
        style = theme.textTheme.subtitle2;
        break;
      default:
        style = theme.textTheme.bodyText2;
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: style?.copyWith(
                color: titleSubColor ? theme.textTheme.caption?.color : theme.textTheme.subtitle1?.color),
          ),
        ),
        Text(subtitle, style: style?.copyWith(color: theme.textTheme.subtitle1?.color)),
      ],
    );
  }
}
