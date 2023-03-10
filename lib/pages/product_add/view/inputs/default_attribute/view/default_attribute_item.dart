import 'package:flutter/material.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';

import '../model/default_attribute_data.dart';

class DefaultAttributeItem extends StatelessWidget {
  final AttributeData attribute;
  final DefaultAttributeData? value;
  final ValueChanged<DefaultAttributeData> changeValue;

  const DefaultAttributeItem({
    Key? key,
    required this.attribute,
    required this.value,
    required this.changeValue,
  }) : super(key: key);

  List<Option> getOptionData(Option optionAll) {
    final List<Option> result = [optionAll];

    OptionData optionData = attribute.option;

    if (optionData.type == OptionDataType.custom) {
      List<String> arrCustom = optionData.custom.split('|').map((element) => element.trim()).toSet().toList();
      for (int i = 0; i < arrCustom.length; i++) {
        final String text = arrCustom[i].trim();
        result.add(Option(key: text, name: text));
      }
    } else {
      for (int i = 0; i < optionData.term.length; i++) {
        final term = optionData.term[i];
        result.add(Option(key: term.slug ?? '', name: term.name ?? ''));
      }
    }

    return result;
  }

  void changeValueOption(Option data) {
    changeValue(DefaultAttributeData(
      id: attribute.id,
      name: attribute.name ?? '',
      option: data.key != attribute.key ? data.key : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Option initAll = Option(
      key: attribute.key,
      name: AppLocalizations.of(context)!.translate('product:text_none_term', {'term': attribute.name ?? ''}),
    );
    List<Option> options = getOptionData(initAll);
    Option valueOption = options.firstWhere((element) => element.key == value?.option, orElse: () => initAll);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInput(title: attribute.name ?? ''),
        InputDropdown2(
          onChanged: changeValueOption,
          options: options,
          value: valueOption,
        ),
      ],
    );
  }
}
