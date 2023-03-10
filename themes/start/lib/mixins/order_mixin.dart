import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class OrderMixin {
  Widget buildIcon({required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 20, width: 20);
    }
    return Icon(
      CommunityMaterialIcons.receipt,
      size: 20,
      color: theme.primaryColor,
    );
  }

  Widget buildId({String? text, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(height: 22, width: 54);
    }
    return Text(text ?? '', style: theme.textTheme.subtitle1);
  }

  Widget buildStatus({String? text, Color? color, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 20,
        width: 83,
        radius: 10,
      );
    }

    return Badge(title: text ?? '', background: color ?? theme.primaryColor, padHorizontal: 12);
  }

  Widget buildDateTimeUser(
      {String? date, String? time, String? vendor, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 280;
          return AnimatedShimmer(height: 15, width: width);
        },
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        Text(date ?? '', style: theme.textTheme.overline),
        Text(time ?? '', style: theme.textTheme.overline),
        Text(vendor ?? '', style: theme.textTheme.overline),
      ],
    );
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

  Widget buildInfo({
    String? product,
    String? earning,
    String? grossSale,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return buildItemInfo(
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 260;
              return AnimatedShimmer(height: 17, width: width);
            },
          ),
          theme: theme);
    }
    return Column(
      children: [
        buildItemInfo(
          child: Text(
            product ?? '',
            maxLines: 1,
            style: theme.textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
          theme: theme,
        ),
        buildItemInfo(
          child: Text(
            earning ?? '',
            maxLines: 1,
            style: theme.textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
          theme: theme,
        ),
        buildItemInfo(
          child: Text(
            grossSale ?? '',
            maxLines: 1,
            style: theme.textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
          theme: theme,
        ),
      ],
    );
  }
}
