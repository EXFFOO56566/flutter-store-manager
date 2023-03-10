import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';

import '../../bloc/product_add_bloc.dart';
import 'variation/variation.dart';

class ProductVariation extends StatelessWidget {
  static const List<String> visible = ['variable'];

  final List<AttributeData> attributes;

  const ProductVariation({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) =>
          previous.variations != current.variations || previous.skuParent != current.skuParent,
      builder: (context, state) {
        return ExpansionView(
          title: Text(translate('product:text_variations')),
          isSecondary: true,
          expandedAlignment: AlignmentDirectional.topStart,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.only(top: 16, bottom: 8),
          children: [
            if (attributes.isNotEmpty) ...[
              VariationList(
                idProduct: state.id,
                idsVariation: state.variations.value,
                onChanged: (id) => context.read<ProductAddBloc>().add(VariationChanged(id)),
                attributes: attributes,
                skuParent: state.skuParent,
              ),
            ] else
              Text(translate('product:text_empty_attribute_variation')),
          ],
        );
      },
    );
  }
}
