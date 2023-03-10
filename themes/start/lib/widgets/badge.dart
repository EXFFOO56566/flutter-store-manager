import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String title;
  final IconData? icon;
  final IconData? iconRight;
  final Color background;
  final Color color;
  final double size;
  final double padHorizontal;
  final double padIcon;
  final double sizeIcon;
  final double? radius;
  final TextStyle? titleStyle;

  const Badge({
    Key? key,
    required this.title,
    this.icon,
    this.iconRight,
    required this.background,
    this.color = Colors.white,
    this.size = 20,
    this.padHorizontal = 7,
    this.padIcon = 3,
    this.sizeIcon = 12,
    this.radius,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? style = titleStyle ?? theme.textTheme.overline;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padHorizontal),
      height: size,
      constraints: BoxConstraints(minWidth: size),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius ?? size / 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: sizeIcon, color: color),
            SizedBox(width: padIcon),
          ],
          Text(title, style: style?.copyWith(color: color, height: size / (style.fontSize ?? 10))),
          if (iconRight != null) ...[
            SizedBox(width: padIcon),
            Icon(iconRight, size: sizeIcon, color: color),
          ],
        ],
      ),
    );
  }
}
