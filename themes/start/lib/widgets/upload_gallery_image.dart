import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/label_input.dart';

double _pad = 12;

class UploadGalleryImage extends StatelessWidget {
  final String? title;
  final List<Widget> images;
  final GestureTapCallback clickUpload;

  const UploadGalleryImage({
    Key? key,
    this.title,
    required this.images,
    required this.clickUpload,
  })  : assert(images.length >= 0),
        super(key: key);

  Widget buildButtonUpload(ThemeData theme) {
    return InkWell(
      onTap: clickUpload,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: theme.colorScheme.surface),
        child: const Icon(CommunityMaterialIcons.cloud_upload),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true) LabelInput(title: title ?? ''),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              buildButtonUpload(theme),
              if (images.isNotEmpty)
                ...images.map(
                  (e) => Padding(
                    padding: EdgeInsetsDirectional.only(start: _pad),
                    child: e,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageUploadItem extends StatelessWidget {
  final Widget image;
  final GestureTapCallback onRemove;

  const ImageUploadItem({
    Key? key,
    required this.image,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        image,
        PositionedDirectional(
          top: 0,
          end: -3,
          child: InkResponse(
            onTap: onRemove,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
              child: const Icon(CommunityMaterialIcons.close_thick, size: 13, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
