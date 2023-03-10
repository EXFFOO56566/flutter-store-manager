import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';
import 'dart:ui' as ui;

import 'container_secondary.dart';

class ViewReport extends StatelessWidget {
  final IconData icon;
  final String title;
  final String titleNumber;
  final String? symbolNumber;
  final double? percent;
  final Color? colorNumber;
  final Color colorIcon;

  const ViewReport({
    Key? key,
    required this.icon,
    required this.title,
    required this.titleNumber,
    required this.colorIcon,
    this.symbolNumber,
    this.percent,
    this.colorNumber,
  }) : super(key: key);

  Widget buildIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: colorIcon,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 20, color: Colors.white),
    );
  }

  Widget buildTitleNumber(ThemeData theme) {
    return Tooltip(
      decoration: BoxDecoration(
        color: theme.dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      verticalOffset: -50,
      margin: const EdgeInsets.only(right: 55),
      richMessage: TextSpan(
        children: [
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: Text(
              symbolNumber?.isNotEmpty == true ? '$symbolNumber ' : '',
              style: theme.textTheme.headline6?.copyWith(fontSize: 14, color: colorNumber),
            ),
          ),
          TextSpan(text: titleNumber),
        ],
        style: theme.textTheme.headline6?.copyWith(color: colorNumber),
      ),
      child: Row(
        children: [
          Text(
            symbolNumber?.isNotEmpty == true ? '$symbolNumber ' : '',
            style: theme.textTheme.headline6?.copyWith(fontSize: 14, color: colorNumber),
          ),
          Expanded(
            child: Text(
              titleNumber,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headline6?.copyWith(color: colorNumber),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPercent(ThemeData theme) {
    if (percent != null) {
      dynamic valuePercent = percent == percent!.toInt() ? percent!.toInt() : percent!;
      String text = valuePercent >= 0 ? '+$valuePercent%' : '$valuePercent%';
      IconData iconPercent = valuePercent >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
      Color colorPercent = valuePercent >= 0 ? const Color(0xFF2BBD69) : theme.colorScheme.error;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: theme.textTheme.overline?.copyWith(color: colorPercent)),
          Icon(
            iconPercent,
            size: 12,
            color: colorPercent,
          ),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ContainerSecondary(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: thirdShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [buildIcon(), const SizedBox(width: 12), Flexible(child: buildPercent(theme))],
          ),
          const SizedBox(height: 12),
          buildTitleNumber(theme),
          Text(title, style: theme.textTheme.caption),
        ],
      ),
    );
  }
}
