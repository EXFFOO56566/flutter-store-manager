import 'package:flutter/material.dart';

import 'fields/fields.dart';

class ProductFormSimple extends StatelessWidget {
  const ProductFormSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldName(),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: FieldRegularPrice()),
            SizedBox(width: 12),
            Expanded(child: FieldSalePrice()),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: FieldSku()),
            SizedBox(width: 12),
            Expanded(child: FieldStockQuantity()),
          ],
        ),
        const SizedBox(height: 15),
        const FieldStockSwitch(),
        const SizedBox(height: 15),
        const FieldDescription(),
        const SizedBox(height: 15),
        const FieldFeatureImage(),
        const SizedBox(height: 40),
        const FieldGalleryImage(),
        const SizedBox(height: 40),
        const FieldCategory(),
        const SizedBox(height: 40),
        const FieldVisibility(),
      ],
    );
  }
}
