import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class DeliveryMixin {
  Widget buildIcon({required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 20, width: 20);
    }
    return Icon(
      CommunityMaterialIcons.truck_delivery,
      size: 20,
      color: theme.primaryColor,
    );
  }

  Widget buildId({String? text, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 17, width: 150);
    }
    return Text(text ?? '', style: theme.textTheme.subtitle1);
  }

  Widget? buildRemaining({Widget? child, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 19,
        width: 80,
      );
    }
    return child;
  }

  Widget buildStatus({String? text, Color? color, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 20, width: 60, radius: 10);
    }

    return Badge(title: text ?? '', background: color ?? theme.primaryColor, padHorizontal: 12);
  }

  Widget buildPaymentType({String? payment, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 20, width: 100);
    }
    return Text(payment ?? '', style: theme.textTheme.overline);
  }

  Widget buildItemInfo({required Widget child, required ThemeData theme}) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: theme.dividerColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [child],
          ),
        ),
      ],
    );
  }

  Widget buildProduct({
    String? product,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 245;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return buildItemInfo(
      child: Text(
        product ?? '',
        maxLines: 1,
        style: theme.textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
      theme: theme,
    );
  }
}
