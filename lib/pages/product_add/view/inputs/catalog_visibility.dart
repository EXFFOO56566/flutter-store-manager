import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../bloc/product_add_bloc.dart';

class ProductVisibility extends StatefulWidget {
  const ProductVisibility({Key? key}) : super(key: key);

  @override
  ProductVisibilityState createState() => ProductVisibilityState();
}

class ProductVisibilityState extends State<ProductVisibility> {
  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    List<Option> options = [
      Option(key: 'visible', name: translate('product:text_shop_search')),
      Option(key: 'catalog', name: translate('product:text_shop_only')),
      Option(key: 'search', name: translate('product:text_search_only')),
      Option(key: 'hidden', name: translate('product:text_hidden')),
    ];
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.catalogVisibility != current.catalogVisibility,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: translate('product:text_catalog_visibility'), isLarge: true),
            InputSelect(
              value: state.catalogVisibility.value,
              options: options,
              onChanged: (String value) => setState(() {
                context.read<ProductAddBloc>().add(CatalogVisibilityChanged(value));
              }),
            )
          ],
        );
      },
    );
  }
}
