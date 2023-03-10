import 'package:flutter/material.dart';
import 'package:ui/widgets/animated_shimmer.dart';

class VariationMixin {
  Widget buildTitle({
    Widget? title,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 80, height: 24);
    }
    return title ?? Container();
  }

  Widget buildAttribute({
    String? text,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 110, height: 17);
    }
    return Text(text ?? '', style: theme.textTheme.caption);
  }

  Widget buildButtonDelete({
    Widget? child,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 24, height: 24);
    }
    return child ?? Container();
  }
}
