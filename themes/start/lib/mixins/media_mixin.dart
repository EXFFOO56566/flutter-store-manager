import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';
import 'package:ui/widgets/animated_shimmer.dart';

class MediaMixin {
  Widget buildAvatar({
    String? url,
    double width = 100,
    double height = 100,
    double radio = 8,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return AnimatedShimmer(width: width, height: height, radius: radio);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radio),
      child: CacheImageView(
        image: url ?? '',
        width: width,
        height: height,
      ),
    );
  }

  Widget buildCheckSelect({
    bool isSelect = false,
    EdgeInsetsGeometry? padding,
    required GestureTapCallback onTap,
    required ThemeData theme,
  }) {
    Widget child = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.white),
      ),
    );
    if (isSelect) {
      child = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: Colors.white),
        ),
        alignment: Alignment.center,
        child: const Icon(CommunityMaterialIcons.check_bold, size: 14, color: Colors.white),
      );
    }
    return InkResponse(
      onTap: onTap,
      radius: 30,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
        alignment: AlignmentDirectional.bottomStart,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
