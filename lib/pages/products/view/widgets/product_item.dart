// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_html/flutter_html.dart';

// Repository packages
import 'package:products_repository/products_repository.dart';

// Theme
import 'package:flutter_store_manager/themes.dart';

double _size = 80;

class ProductItem extends StatelessWidget with ProductMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final Product product;
  final int index;
  final GestureTapCallback? onTap;

  const ProductItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    required this.product,
    required this.index,
    this.onTap,
  }) : super(key: key);

  String? get image {
    if (product.images != null && product.images!.isNotEmpty) {
      Map<String, dynamic> data = product.images![0];

      if (data.containsKey('woocommerce_thumbnail')) {
        return data['woocommerce_thumbnail'];
      }

      if (data.containsKey('woocommerce_single')) {
        return data['woocommerce_single'];
      }

      if (data.containsKey('woocommerce_gallery_thumbnail')) {
        return data['woocommerce_gallery_thumbnail'];
      }

      if (data.containsKey('src')) {
        return data['src'];
      }
    }
    return null;
  }

  Widget buildTypeProduct(BuildContext context, {required ThemeData theme, bool loading = false}) {
    late String text;
    switch (product.type) {
      case ProductTypeModel.variable:
        text = AppLocalizations.of(context)!.translate('product:text_variable_sub');
        break;
      case ProductTypeModel.grouped:
        text = AppLocalizations.of(context)!.translate('product:text_group_sub');
        break;
      case ProductTypeModel.external:
        text = AppLocalizations.of(context)!.translate('product:text_external_sub');
        break;
      default:
        text = AppLocalizations.of(context)!.translate('product:text_simple_sub');
    }
    return buildType(type: text, theme: theme, isLoading: loading);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = product.id == null;
    return ProductItemUi(
      image: buildImage(url: image, size: _size, isLoading: loading),
      name: buildName(name: product.name.toString().unescape, theme: theme, isLoading: loading),
      price: buildPrice(
        price: Price(price: product.priceHtml ?? ''),
        isLoading: loading,
      ),
      type: buildTypeProduct(context, theme: theme, loading: loading),
      padding: padding,
      indentDivider: indentDivider ?? _size + 20,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: !loading ? onTap : null,
    );
  }
}

class Price extends StatelessWidget {
  final String price;

  const Price({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle styleSale = theme.textTheme.bodyText2!.copyWith(color: theme.colorScheme.error);
    TextStyle? styleRegular = theme.textTheme.bodyText2;
    return Html(
      data: price.replaceFirst('del>', 'del>&nbsp;'),
      shrinkWrap: true,
      style: {
        'html': Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
        'body': Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
        'del': Style.fromTextStyle(
            styleRegular!.copyWith(decoration: TextDecoration.lineThrough, color: theme.textTheme.caption?.color)),
        'ins': Style.fromTextStyle(styleSale),
      },
    );
  }
}
