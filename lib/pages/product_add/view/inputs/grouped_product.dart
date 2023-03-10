import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/product_add/bloc/product_add_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'grouped_product/grouped_product.dart';

class ProductGroupedProduct extends StatelessWidget {
  static const List<String> visible = ['grouped'];

  const ProductGroupedProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.groupedProducts != current.groupedProducts,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelInput(title: 'Grouped products'),
            ProductGroupedListItem(
              id: state.id,
              productIds: state.groupedProducts.value,
              onChanged: (value) => context.read<ProductAddBloc>().add(GroupedProductChanged(value)),
            ),
          ],
        );
      },
    );
  }
}
