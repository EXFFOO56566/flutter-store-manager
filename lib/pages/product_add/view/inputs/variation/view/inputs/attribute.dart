import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';

import '../../../default_attribute/default_attribute.dart';
import '../../bloc/variation_bloc.dart';

class VariationAttribute extends StatelessWidget {
  final List<AttributeData> attributes;

  const VariationAttribute({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.attributes != current.attributes,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(attributes.length, (index) {
            AttributeData attribute = attributes[index];
            DefaultAttributeData? value = state.attributes.value
                .firstWhereOrNull((element) => element.id == attribute.id && element.name == attribute.name);
            double padBottom = index < attributes.length - 1 ? 15 : 0;

            return Padding(
              padding: EdgeInsets.only(bottom: padBottom),
              child: _AttributeItem(
                attribute: attribute,
                value: value,
                changeValue: (data) => context.read<VariationBloc>().add(AttributeChanged(data)),
              ),
            );
          }),
        );
      },
    );
  }
}

class _AttributeItem extends StatelessWidget {
  final AttributeData attribute;
  final DefaultAttributeData? value;
  final ValueChanged<DefaultAttributeData> changeValue;

  const _AttributeItem({
    Key? key,
    required this.attribute,
    this.value,
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
        result.add(Option(key: term.name ?? '', name: term.name ?? ''));
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
