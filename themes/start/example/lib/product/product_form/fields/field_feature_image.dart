import 'package:flutter/material.dart';

import '../../../widgets/select_image.dart';

class FieldFeatureImage extends StatelessWidget {
  const FieldFeatureImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SelectImage(label: 'Feature Image');
  }
}
