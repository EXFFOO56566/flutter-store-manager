import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';

class OrderChartItemInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color colorLine;

  const OrderChartItemInfo({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.colorLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 103),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.cardColor,
        boxShadow: fifthShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Stack(
            fit: StackFit.passthrough,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  subtitle,
                  style: theme.textTheme.subtitle2,
                  maxLines: 2,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(height: 2, color: colorLine),
              )
            ],
          )
        ],
      ),
    );
  }
}
