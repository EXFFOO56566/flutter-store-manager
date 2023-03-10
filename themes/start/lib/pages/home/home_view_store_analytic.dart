import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';
import 'package:ui/widgets/container_secondary.dart';

class HomeViewStoreAnalytic extends StatelessWidget {
  final String title;
  final Widget chart;

  const HomeViewStoreAnalytic({
    Key? key,
    required this.title,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ContainerSecondary(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: secondaryShadow,
      padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.subtitle2),
          const SizedBox(height: 15),
          chart,
        ],
      ),
    );
  }
}
