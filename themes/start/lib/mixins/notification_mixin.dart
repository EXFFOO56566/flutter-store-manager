import 'package:flutter/material.dart';
import 'package:ui/widgets/animated_shimmer.dart';

class NotificationMixin {
  Widget buildIcon({IconData? icon, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(width: 50, height: 50, radius: 25);
    }
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: theme.primaryColor, shape: BoxShape.circle),
      child: Icon(icon ?? Icons.chat, size: 20, color: Colors.white),
    );
  }

  Widget buildTitle({String? text, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 255;
          return AnimatedShimmer(height: 19, width: width);
        },
      );
    }
    return Text(
      text ?? '',
      style: theme.textTheme.subtitle2,
    );
  }

  Widget buildDateTime({String? date, String? time, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return Wrap(
        spacing: 8,
        children: const [
          AnimatedShimmer(height: 15, width: 60),
          AnimatedShimmer(height: 15, width: 60),
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

  Widget buildStatus({String? text, Color? color, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 15,
        width: 60,
      );
    }
    return Text(
      text ?? '',
      style: theme.textTheme.overline?.copyWith(color: color),
    );
  }

  Widget buildType({bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 8,
        width: 8,
        radius: 4,
      );
    }

    return Container(
      width: 8,
      height: 8,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color(0xFF2BBD69), shape: BoxShape.circle),
    );
  }
}
