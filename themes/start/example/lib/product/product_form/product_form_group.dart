import 'package:flutter/material.dart';

import 'fields/fields.dart';

class ProductFormGroup extends StatelessWidget {
  const ProductFormGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        FieldName(),
        SizedBox(height: 15),
        FieldDescription(),
        SizedBox(height: 15),
        FieldFeatureImage(),
        SizedBox(height: 40),
        FieldGalleryImage(),
        SizedBox(height: 40),
        FieldCategory(),
        SizedBox(height: 40),
        FieldVisibility(),
        SizedBox(height: 16),
        FieldGroupProducts(),
      ],
    );
  }
}
