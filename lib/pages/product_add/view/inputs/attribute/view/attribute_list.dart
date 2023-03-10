/// Flutter library
import 'package:flutter/material.dart';
import 'package:products_repository/products_repository.dart';

/// Packages and Dependencies
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../widget/attribute_button_save.dart';

/// Inputs
import '../widget/option_view.dart';
import '../widget/attribute_item.dart';
import 'attribute_page.dart';

class AttributeList extends StatefulWidget {
  final List<AttributeData> attributes;
  final ValueChanged<List<AttributeData>> onAddAttribute;
  final ValueChanged<String> onDeleteAttribute;
  final ValueChanged<AttributeData> onUpdateAttribute;
  final bool showVariation;

  const AttributeList({
    Key? key,
    required this.attributes,
    required this.onAddAttribute,
    required this.onDeleteAttribute,
    required this.onUpdateAttribute,
    this.showVariation = false,
  }) : super(key: key);

  @override
  AttributeListState createState() => AttributeListState();
}

class AttributeListState extends State<AttributeList> {
  void clickAdd(TranslateType translate) async {
    final List<Option> selectOption = [];
    for (int i = 0; i < widget.attributes.length; i++) {
      AttributeData attr = widget.attributes[i];
      if (attr.id != 0) {
        selectOption.add(Option(key: '${attr.id}', name: attr.name ?? ''));
      }
    }
    List<AttributeData>? value = await showModalBottomSheet<List<AttributeData>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.7),
          child: AttributePage(
            selected: selectOption,
            onAddCustom: () {
              Navigator.pop(context, [
                AttributeData.fromJson({
                  "id": 0,
                  'name': '',
                  'visible': true,
                  'variation': true,
                  'options': [],
                })
              ]);
            },
            onAddTerm: (List<Option>? data) {
              List<AttributeData>? result;
              if (data?.isNotEmpty == true) {
                for (int i = 0; i < data!.length; i++) {
                  Option item = data[i];
                  if (selectOption.indexWhere((element) => element.key == item.key) < 0) {
                    result ??= [];
                    result.add(AttributeData.fromJson({
                      "id": ConvertData.stringToInt(item.key),
                      'name': item.name,
                      'visible': true,
                      'variation': false,
                      'options': [],
                    }));
                  }
                }
              }
              Navigator.pop(context, result);
            },
          ),
        );
      },
    );
    if (value != null) {
      widget.onAddAttribute(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return ExpansionView(
      title: Text(translate('product:text_attributes')),
      expandedAlignment: AlignmentDirectional.topStart,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.only(top: 16, bottom: 8),
      isSecondary: true,
      children: [
        if (widget.attributes.isNotEmpty == true) ..._buildAttributes(widget.attributes),
        _buildButtonAddAttribute(translate),
      ],
    );
  }

  List<Widget> _buildAttributes(List<AttributeData> attributes) {
    return List.generate(
      attributes.length,
      (index) {
        AttributeData attribute = attributes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AttributeItem(
            key: Key('attribute_view_${attribute.key}'),
            attribute: attribute,
            option: OptionView(
              attribute: attribute,
              onUpdateAttribute: widget.onUpdateAttribute,
            ),
            onDeleteAttribute: widget.onDeleteAttribute,
            onUpdateAttribute: widget.onUpdateAttribute,
            showVariation: widget.showVariation,
          ),
        );
      },
    );
  }

  Widget _buildButtonAddAttribute(TranslateType translate) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => clickAdd(translate),
            style: ElevatedButton.styleFrom(
              foregroundColor: theme.textTheme.subtitle1?.color,
              backgroundColor: theme.colorScheme.surface,
              minimumSize: const Size(0, 41),
              textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(translate('product:text_add_attribute')),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: AttributeButtonSave()),
      ],
    );
  }
}
