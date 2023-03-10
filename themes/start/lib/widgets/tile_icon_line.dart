import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class TileIconLine extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final bool isChevron;
  final GestureTapCallback? onTap;

  const TileIconLine({
    Key? key,
    required this.icon,
    required this.title,
    this.trailing,
    this.isChevron = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BoxDividerUi(
      indentDivider: 44,
      color: theme.dividerColor,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: theme.textTheme.overline?.color,
        ),
        title: Text(title, style: theme.textTheme.bodyText2),
        horizontalTitleGap: 20,
        minLeadingWidth: 24,
        contentPadding: EdgeInsets.zero,
        trailing: isChevron || trailing != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailing != null) trailing ?? Container(),
                  if (isChevron)
                    Container(
                      width: 28,
                      alignment: Alignment.center,
                      child: const Icon(Icons.chevron_right, size: 22),
                    )
                ],
              )
            : null,
      ),
    );
  }
}
