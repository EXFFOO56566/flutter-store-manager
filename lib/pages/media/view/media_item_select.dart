import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:media_repository/media_repository.dart';

import 'media_item.dart';

class MediaItemSelect extends StatelessWidget with MediaMixin {
  final Media item;
  final double width;
  final double height;

  const MediaItemSelect({
    Key? key,
    required this.item,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaCubit cubit = context.read<MediaCubit>();
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        bool checkSelect = state.mediaSelected.indexWhere((element) => element.id == item.id) > -1;
        Widget child = MediaItem(
          item: item,
          width: width,
          height: height,
          radius: 8,
          isOpacity: checkSelect,
        );

        if (item.id == 0) {
          return child;
        }

        return Stack(
          children: [
            child,
            PositionedDirectional(
              bottom: 0,
              start: 0,
              child: buildCheckSelect(
                isSelect: checkSelect,
                theme: theme,
                onTap: () {
                  cubit.setMedia(media: item);
                  switch (cubit.getFromGalleryType) {
                    case GetFromGalleryType.aPic:
                      Navigator.pop(context, item);
                      break;
                    default:
                      break;
                  }
                },
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
              ),
            )
          ],
        );
      },
    );
  }
}
