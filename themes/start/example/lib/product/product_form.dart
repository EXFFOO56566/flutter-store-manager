import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../contants.dart';
import 'product_form/product_form_field.dart';

class ProductFormScreen extends StatefulWidget {
  static const routeName = '/product_form';

  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> with AppbarMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final args = ModalRoute.of(context)!.settings.arguments;
    bool isEdit = args is Map && args['isEdit'] is bool ? args['isEdit'] : false;

    String title = isEdit ? 'Name Product' : 'Create New Product';
    String titleButton = isEdit ? 'Update Product' : 'Create Product';

    return Scaffold(
      appBar: baseStyleAppBar(title: title),
      body: FixedBottom(
        bottom: ContainerSecondary(
          color: theme.cardColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          boxShadow: initShadow,
          child: Center(
            child: ElevatedButton(
              child: Text(titleButton),
              onPressed: () {},
            ),
          ),
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, 8, 25, 25),
          child: ProductFormField(),
        ),
      ),
    );
  }
}
