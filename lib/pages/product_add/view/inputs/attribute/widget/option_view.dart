import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import 'modal_term_view.dart';

class OptionView extends StatelessWidget {
  final AttributeData attribute;
  final ValueChanged<AttributeData> onUpdateAttribute;

  const OptionView({
    Key? key,
    required this.attribute,
    required this.onUpdateAttribute,
  }) : super(key: key);

  void onChangeOption(OptionData optionData) {
    AttributeData data = attribute;
    data.option = optionData;
    onUpdateAttribute(data);
  }

  void onChangeName(String value) {
    AttributeData data = attribute;
    data.name = value;
    onUpdateAttribute(data);
  }

  void onChangeOptionCustom(String value) {
    OptionData data = attribute.option;
    data.custom = value;
    onChangeOption(data);
  }

  void onClickTermModal(BuildContext context) async {
    List<OptionTerm>? value = await showModalBottomSheet<List<OptionTerm>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.7),
          child: ModalTermView(
            idAttribute: attribute.id,
            selectTerm: attribute.option.term,
            changeTerm: (List<OptionTerm>? data) {
              Navigator.pop(context, data);
            },
          ),
        );
      },
    );
    if (value != null) {
      OptionData optionData = attribute.option;
      optionData.term = value;
      onChangeOption(optionData);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    OptionData optionData = attribute.option;

    if (optionData.type == OptionDataType.custom) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            InputTextField(
              key: Key('input_attribute_name_${attribute.key}'),
              label: translate('inputs:text_name'),
              initialValue: attribute.name ?? '',
              onChanged: onChangeName,
            ),
            const SizedBox(height: 8),
            InputTextField(
              key: Key('input_attribute_value_${attribute.key}'),
              label: translate('inputs:text_values'),
              onChanged: onChangeOptionCustom,
              decoration: InputDecoration(hintText: translate('product:text_hint_value')),
              maxLines: 2,
              initialValue: optionData.custom,
            ),
          ],
        ),
      );
    }
    List<Option> optionSelected = optionData.term.map((e) => Option(key: '${e..id}', name: e.name ?? '')).toList();

    return InputGroupOption(
      value: optionSelected,
      trailing: InkResponse(
        onTap: () => onClickTermModal(context),
        child: const Icon(CommunityMaterialIcons.chevron_right),
      ),
      onChanged: (data) {
        int visit = optionSelected.indexWhere((element) => !data.contains(element));
        if (visit > -1) {
          List<OptionTerm> term = [
            ...optionData.term,
          ];
          term.removeAt(visit);
          optionData.term = term;
          onChangeOption(optionData);
        }
      },
    );
  }
}
