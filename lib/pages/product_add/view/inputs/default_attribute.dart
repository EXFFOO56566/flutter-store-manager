import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';

import '../../bloc/product_add_bloc.dart';
import 'default_attribute/default_attribute.dart';

class ProductDefaultAttribute extends StatelessWidget {
  static const List<String> visible = ['variable'];

  final List<AttributeData> attributes;

  const ProductDefaultAttribute({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.defaultAttributes != current.defaultAttributes,
      builder: (context, state) {
        return DefaultAttributeView(
          attributes: attributes,
          values: state.defaultAttributes.value,
          changeValue: (data) => context.read<ProductAddBloc>().add(DefaultAttributeChanged(data)),
        );
      },
    );
  }
}
