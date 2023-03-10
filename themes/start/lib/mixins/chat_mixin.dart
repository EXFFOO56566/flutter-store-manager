import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';
import 'package:ui/widgets/animated_shimmer.dart';
import 'package:ui/widgets/badge.dart';

class ChatMixin {
  Widget buildImage({
    String? url,
    Color? colorDot,
    bool isLoading = false,
    required ThemeData theme,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 60, height: 60, radius: 30);
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CacheImageView(
            image: url ?? '',
            width: 60,
            height: 60,
            errorWidget: const ImageErrorUserView(),
          ),
        ),
        if (colorDot != null)
          PositionedDirectional(
            end: -5,
            top: 8,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: colorDot,
                border: Border.all(width: 2, color: theme.cardColor),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildName({
    String? text,
    bool isLoading = false,
    required ThemeData theme,
  }) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 180;
          return AnimatedShimmer(height: 19, width: width);
        },
      );
    }
    return Text(text ?? '', style: theme.textTheme.subtitle2);
  }

  Widget buildTime({
    String? text,
    bool isLoading = false,
    required ThemeData theme,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 44, height: 18);
    }
    return Text(text ?? '', style: theme.textTheme.overline);
  }

  Widget buildMessage({
    String? text,
    bool isLoading = false,
    required ThemeData theme,
  }) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 195;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return Text(
      text ?? '',
      style: theme.textTheme.caption,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildCount({
    String? text,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return const AnimatedShimmer(width: 20, height: 20, radius: 10);
    }
    return Badge(
      title: text ?? '',
      background: const Color(0xFFFA1616),
      padHorizontal: 4,
    );
  }
}
