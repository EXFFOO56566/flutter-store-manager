import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldGalleryImage extends StatelessWidget {
  const FieldGalleryImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UploadGalleryImage(
      title: 'Image Gallery',
      images: const [],
      clickUpload: () {},
    );
  }
}
