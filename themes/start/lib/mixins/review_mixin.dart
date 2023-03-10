import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';
import 'package:ui/widgets/animated_shimmer.dart';
import 'package:ui/widgets/badge.dart';

class ReviewMixin {
  Widget buildAvatar({String? url, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(width: 60, height: 60, radius: 30);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CacheImageView(
        image: url ?? '',
        width: 60,
        height: 60,
      ),
    );
  }

  Widget buildName({String? name, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 180;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return Text(
      name ?? '',
      style: theme.textTheme.subtitle2,
    );
  }

  Widget buildDateTime({String? date, String? time, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return Wrap(
        spacing: 8,
        children: const [
          AnimatedShimmer(height: 15, width: 58),
          AnimatedShimmer(height: 15, width: 58),
        ],
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        Text(date ?? '', style: theme.textTheme.overline),
        Text(time ?? '', style: theme.textTheme.overline),
      ],
    );
  }

  Widget buildStatus({String? status, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 15,
        width: 46,
      );
    }
    return Text(status ?? '', style: theme.textTheme.overline);
  }

  Widget buildDescription({String? description, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 245;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return Text(
      description ?? '',
      style: theme.textTheme.caption,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildRating({String? rating, required Color color, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 21,
        width: 45,
        radius: 12,
      );
    }
    return Badge(
      icon: Icons.star,
      title: rating ?? '0.0',
      background: color,
      size: 21,
    );
  }
}
