import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';
import 'package:ui/widgets/animated_shimmer.dart';

class ProductMixin {
  Widget buildImage({
    String? url,
    double size = 80,
    double radius = 10,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return AnimatedShimmer(width: size, height: size, radius: radius);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CacheImageView(
        image: url ?? '',
        width: size,
        height: size,
      ),
    );
  }

  Widget buildName({
    String? name,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 220;
          return AnimatedShimmer(height: 19, width: width);
        },
      );
    }
    return Text(
      name ?? '',
      style: theme.textTheme.subtitle2,
    );
  }

  Widget buildPrice({Widget? price, bool isLoading = false}) {
    if (isLoading) {
      return Wrap(
        spacing: 8,
        children: const [
          AnimatedShimmer(height: 17, width: 43),
          AnimatedShimmer(height: 17, width: 43),
        ],
      );
    }
    return price ?? Container();
  }

  Widget buildType({String? type, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 15, width: 43);
    }
    return Text(
      type ?? 'Simple',
      style: theme.textTheme.overline,
    );
  }
}
