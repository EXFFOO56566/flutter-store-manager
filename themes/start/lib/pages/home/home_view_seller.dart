import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';
import 'package:ui/widgets/container_secondary.dart';

class HomeViewSeller extends StatelessWidget {
  final String title;
  final Widget chart;
  final Widget noteChart;

  const HomeViewSeller({
    Key? key,
    required this.title,
    required this.chart,
    required this.noteChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ContainerSecondary(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: secondaryShadow,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 33),
      child: Row(
        children: [
          chart,
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.subtitle2),
                const SizedBox(height: 13),
                noteChart,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
