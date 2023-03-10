import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import 'variable_container.dart';

class AttributeItem extends StatelessWidget {
  final AttributeData attribute;
  final Widget option;
  final ValueChanged<String> onDeleteAttribute;
  final ValueChanged<AttributeData> onUpdateAttribute;
  final bool showVariation;

  const AttributeItem({
    Key? key,
    required this.option,
    required this.attribute,
    required this.onDeleteAttribute,
    required this.onUpdateAttribute,
    this.showVariation = false,
  }) : super(key: key);

  Future<void> _onDelete(BuildContext context, TranslateType translate) async {
    String? value = await showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('common:text_delete')),
          content: Text(translate('product:text_content_remove', {'name': attribute.name ?? ''})),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: Text(translate('common:text_cancel'))),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(translate('common:text_ok')),
            ),
          ],
        );
      },
    );
    if (value == 'OK') {
      onDeleteAttribute(attribute.key);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    ThemeData theme = Theme.of(context);

    return VariableContainer(
      children: [
        ExpansionView(
          title: Text(attribute.name ?? ''),
          initiallyExpanded: true,
          isSecondary: true,
          expandedAlignment: AlignmentDirectional.topStart,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(translate('product:text_visit_product'), style: theme.textTheme.bodyText2),
              contentPadding: EdgeInsets.zero,
              leading: CupertinoSwitch(
                value: attribute.visible,
                onChanged: (bool value) {
                  AttributeData data = attribute;
                  data.visible = value;
                  onUpdateAttribute(data);
                },
              ),
              horizontalTitleGap: 11,
              minLeadingWidth: 0,
            ),
            if (showVariation) ...[
              const Divider(height: 1, thickness: 1),
              ListTile(
                title: Text(translate('product:text_use_variation'), style: theme.textTheme.bodyText2),
                contentPadding: EdgeInsets.zero,
                leading: CupertinoSwitch(
                  value: attribute.variation,
                  onChanged: (bool value) {
                    AttributeData data = attribute;
                    data.variation = value;
                    onUpdateAttribute(data);
                  },
                ),
                horizontalTitleGap: 11,
                minLeadingWidth: 0,
              ),
            ],
            const SizedBox(height: 8),
            option,
            const SizedBox(height: 16),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton(
                onPressed: () => _onDelete(context, translate),
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.textTheme.subtitle1?.color,
                  backgroundColor: theme.colorScheme.surface,
                  textStyle: theme.textTheme.overline,
                  minimumSize: const Size(0, 29),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CommunityMaterialIcons.trash_can_outline, size: 16),
                    const SizedBox(width: 8),
                    Text(translate('common:text_delete')),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
