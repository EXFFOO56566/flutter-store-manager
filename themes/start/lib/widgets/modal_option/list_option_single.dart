import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/items/box_divider_ui.dart';
import 'package:ui/models/option.dart';

class ListOptionSingle extends StatelessWidget {
  final List<Option> data;
  final String? keySelected;
  final ValueChanged<String> clickSelect;
  final EdgeInsetsGeometry? padding;

  const ListOptionSingle({
    Key? key,
    required this.data,
    required this.clickSelect,
    this.keySelected,
    this.padding,
  }) : super(key: key);

  Color? getColorIconCheck({bool enable = true, bool selected = true, required ThemeData theme}) {
    if (!enable) {
      return theme.disabledColor;
    }
    if (selected) {
      return theme.primaryColor;
    }
    return theme.textTheme.caption?.color;
  }

  Color? getColor({bool enable = true, bool selected = true, required ThemeData theme}) {
    if (!enable) {
      return theme.disabledColor;
    }
    if (selected) {
      return theme.primaryColor;
    }
    return theme.textTheme.subtitle1?.color;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(data.length, (index) {
          Option option = data[index];
          bool isSelect = keySelected == option.key;
          return BoxDividerUi(
            color: theme.dividerColor,
            child: ListTile(
              title: Text(
                option.name,
                style: theme.textTheme.bodyText2?.copyWith(
                  color: getColor(
                    selected: isSelect,
                    enable: option.enabled,
                    theme: theme,
                  ),
                ),
              ),
              trailing: isSelect
                  ? Icon(
                      CommunityMaterialIcons.check,
                      color: getColorIconCheck(
                        selected: isSelect,
                        enable: option.enabled,
                        theme: theme,
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.zero,
              enabled: option.enabled,
              onTap: () => clickSelect(option.key),
            ),
          );
        }),
      ),
    );
  }
}
