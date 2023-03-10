import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImageView extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? backgroundColor;
  final Widget? errorWidget;

  const CacheImageView({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? Theme.of(context).dividerColor,
      child: image == ''
          ? errorWidget ?? const ImageErrorView()
          : CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) {
                return errorWidget ?? const ImageErrorView();
              },
            ),
    );
  }
}

class ImageErrorView extends StatelessWidget {
  const ImageErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 100;
        double height = constraints.maxHeight != double.infinity ? constraints.maxHeight : 100;
        return NoImage(width: width, height: height);
      },
    );
  }
}

class NoImage extends StatelessWidget {
  final double width;
  final double height;

  const NoImage({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surface,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/no_image_icon.png',
        width: width / 2,
        height: height / 2,
        package: 'ui',
        fit: BoxFit.contain,
      ),
    );
  }
}

class ImageErrorUserView extends StatelessWidget {
  const ImageErrorUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 100;
        double height = constraints.maxHeight != double.infinity ? constraints.maxHeight : 100;

        double sizeIcon = width > height ? height * 24 / 60 : width * 24 / 60;
        return Container(
          width: width,
          height: height,
          color: theme.colorScheme.surface,
          alignment: Alignment.center,
          child: Icon(
            CommunityMaterialIcons.account,
            color: theme.textTheme.caption?.color,
            size: sizeIcon,
          ),
        );
      },
    );
  }
}
