import 'package:flutter/material.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:products_repository/products_repository.dart';

import 'variation_add.dart';
import 'variation_edit.dart';

class VariationDetailPage extends StatelessWidget with AppbarMixin {
  final int idProduct;
  final Map<String, dynamic>? data;
  final List<AttributeData> attributes;
  final String skuParent;

  const VariationDetailPage({
    Key? key,
    required this.idProduct,
    this.data,
    required this.attributes,
    this.skuParent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return VariationEditPage(
        idProduct: idProduct,
        data: data!,
        attributes: attributes,
        skuParent: skuParent,
      );
    }
    return VariationAddPage(
      idProduct: idProduct,
      attributes: attributes,
      skuParent: skuParent,
    );
  }
}
