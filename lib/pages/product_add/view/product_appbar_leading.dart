import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';

import '../bloc/product_add_bloc.dart';

enum ProductAppBarTypeAction { add, edit }

class ProductAppbarLeading extends StatelessWidget with AppbarMixin {
  final ProductAppBarTypeAction typeAction;
  const ProductAppbarLeading({
    Key? key,
    this.typeAction = ProductAppBarTypeAction.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.changeStatus != current.changeStatus,
      builder: (context, state) {
        return leading(
          onPressed: () {
            Navigator.pop(context, state.changeStatus);
            if (typeAction == ProductAppBarTypeAction.add && !state.changeStatus) {
              context.read<ProductAddBloc>().add(const ProductDeleteSubmitted());
            }
          },
        );
      },
    );
  }
}
