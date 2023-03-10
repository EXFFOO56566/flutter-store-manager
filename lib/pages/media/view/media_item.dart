import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:media_repository/media_repository.dart';

import 'media_image_page.dart';

class MediaItem extends StatelessWidget with MediaMixin {
  final Media? item;
  final double width;
  final double height;
  final double radius;
  final bool isOpacity;
  const MediaItem({
    Key? key,
    this.item,
    required this.width,
    required this.height,
    this.radius = 0,
    this.isOpacity = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loading = item == null || item?.id == 0;
    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: buildAvatar(
        url: item?.url,
        width: width,
        height: height,
        radio: 0,
        isLoading: loading,
      ),
    );
    final MediaCubit mediaCubit = context.read<MediaCubit>();

    if (!loading) {
      return GestureDetector(
        onTap: () async {
          mediaCubit.onDeleteDefault('idea');
          dynamic data = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MediaImagePage(
                  item: item,
                  mediaCubit: mediaCubit,
                );
              },
              fullscreenDialog: true,
            ),
          );
          if (data is String) {}
        },
        child: Hero(
          tag: 'media-image-${item?.id}',
          child: Stack(
            children: [
              child,
              if (isOpacity)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    }
    return child;
  }
}
