import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';
import 'package:ui/widgets/upload_image.dart';

class SelectImage extends StatelessWidget {
  final String? label;

  const SelectImage({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UploadImage(
      image: const CacheImageView(image: '', width: 80, height: 80),
      clickButton: () {},
      title: label,
    );
  }
}
