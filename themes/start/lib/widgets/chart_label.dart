import 'package:flutter/material.dart';
import 'package:ui/widgets/animated_shimmer.dart';

class ChartLabel extends StatelessWidget {
  final Color color;
  final String name;
  final bool isExpand;
  final bool isLargeText;

  const ChartLabel({
    Key? key,
    required this.color,
    required this.name,
    this.isExpand = true,
    this.isLargeText = false,
  }) : super(key: key);

  const factory ChartLabel.loading({
    Key? key,
    bool isExpand,
  }) = _ChartLabelLoading;

  Widget buildDot() {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildSpacing() {
    if (isLargeText) {
      return const SizedBox(width: 10);
    }
    return const SizedBox(width: 8);
  }

  Widget buildViewText({required Widget child}) {
    if (!isExpand) {
      return Flexible(child: child);
    }
    return Expanded(child: child);
  }

  Widget buildName(ThemeData theme) {
    double size = isLargeText ? 14 : 12;
    return Text(
      name,
      style: theme.textTheme.caption?.copyWith(fontSize: size),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [buildDot(), buildSpacing(), buildViewText(child: buildName(theme))],
    );
  }
}

class _ChartLabelLoading extends ChartLabel {
  const _ChartLabelLoading({
    Key? key,
    bool isExpand = true,
  }) : super(
          key: key,
          color: Colors.white,
          name: '',
          isExpand: isExpand,
          isLargeText: false,
        );

  Widget buildDotWidget(Color color) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildLoadingWidget() {
    return const AnimatedShimmer(
      width: 120,
      height: 17,
      radius: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        buildDotWidget(theme.disabledColor),
        buildSpacing(),
        buildViewText(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLoadingWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
