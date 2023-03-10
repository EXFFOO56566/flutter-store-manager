import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import '../../bloc/product_add_bloc.dart';
import 'attribute/view/attribute_list.dart';
import 'default_attribute.dart';

class ProductAttributeView extends StatelessWidget {
  final bool showVariation;
  const ProductAttributeView({
    Key? key,
    this.showVariation = false,
  }) : super(key: key);

  void addAttribute(BuildContext context, List<AttributeData> data) {
    context.read<ProductAddBloc>().add(AddAttributeChanged(data));
  }

  void deleteAttribute(BuildContext context, String key) {
    context.read<ProductAddBloc>().add(DeleteAttributeChanged(key));
  }

  void updateAttribute(BuildContext context, AttributeData attribute) {
    context.read<ProductAddBloc>().add(UpdateAttributeChanged(attribute));
  }

  Widget buildDefaultAttribute(List<AttributeData> data) {
    List<AttributeData> dataVariation = data.where((element) {
      bool checkCustom = false;
      if (element.option.type == OptionDataType.custom && element.option.custom.isNotEmpty) {
        List arrCustom = element.option.custom.split('|');
        AttributeData? lastAttr = data.lastWhereOrNull(
          (e) =>
              e.name?.isNotEmpty == true &&
              e.variation == true &&
              e.id == element.id &&
              e.name == element.name &&
              e.option.custom.isNotEmpty == true,
        );
        checkCustom = lastAttr?.key == element.key && arrCustom.isNotEmpty;
      }
      return element.name?.isNotEmpty == true &&
          element.variation == true &&
          (checkCustom || (element.option.type == OptionDataType.term || element.option.term.isNotEmpty));
    }).toList();
    if (dataVariation.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ProductDefaultAttribute(
          attributes: dataVariation,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.attributes != current.attributes,
      builder: (context, state) {
        return AttributeList(
          attributes: state.attributes.value,
          onAddAttribute: (List<AttributeData> value) => addAttribute(context, value),
          onDeleteAttribute: (value) => deleteAttribute(context, value),
          onUpdateAttribute: (value) => updateAttribute(context, value),
          showVariation: showVariation,
        );
      },
    );
  }
}
