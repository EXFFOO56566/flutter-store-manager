import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

double _size = 80;

class ProductItem extends StatelessWidget with ProductMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const ProductItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = false;
    return ProductItemUi(
      image: buildImage(url: '', size: _size, isLoading: loading),
      name: buildName(name: 'Asym metric', theme: theme, isLoading: loading),
      price: buildPrice(
        price: Text(
          '\$20.99',
          style: theme.textTheme.bodyText2,
        ),
        isLoading: loading,
      ),
      type: buildType(type: 'Simple', theme: theme, isLoading: loading),
      padding: padding,
      indentDivider: indentDivider ?? _size + 20,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: () => Navigator.pushNamed(context, ProductFormScreen.routeName, arguments: {'isEdit': true}),
    );
  }
}
