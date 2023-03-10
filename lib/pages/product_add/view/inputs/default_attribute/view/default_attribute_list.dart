import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';

import '../model/default_attribute_data.dart';
import 'default_attribute_item.dart';

class DefaultAttributeView extends StatelessWidget {
  final List<AttributeData> attributes;
  final List<DefaultAttributeData> values;
  final ValueChanged<DefaultAttributeData> changeValue;

  const DefaultAttributeView({
    Key? key,
    required this.attributes,
    required this.values,
    required this.changeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return ExpansionView(
      title: Text(translate('product:text_default_attribute')),
      isSecondary: true,
      expandedAlignment: AlignmentDirectional.topStart,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.only(top: 16, bottom: 8),
      children: List.generate(attributes.length, (index) {
        AttributeData attribute = attributes[index];
        DefaultAttributeData? value =
            values.firstWhereOrNull((element) => element.id == attribute.id && element.name == attribute.name);
        double padBottom = index < attributes.length - 1 ? 15 : 0;

        return Padding(
          padding: EdgeInsets.only(bottom: padBottom),
          child: DefaultAttributeItem(
            attribute: attribute,
            value: value,
            changeValue: changeValue,
          ),
        );
      }),
    );
  }
}
