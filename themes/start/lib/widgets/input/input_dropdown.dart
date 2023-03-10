import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/models/option.dart';
import 'package:collection/collection.dart';

import '../modal_option/modal_option_single_view.dart';

class InputDropdown extends StatelessWidget {
  final String? hintText;
  final String? value;
  final ValueChanged<String> onChanged;
  final List<Option> options;
  final bool isExpandModal;
  final bool isSearchModal;
  final String? hintTextSearchModal;
  final double ratioHeightModal;
  final bool isOutline;
  final bool isSmall;
  final String name;
  final Color? borderColor;
  const InputDropdown({
    Key? key,
    this.hintText,
    this.value,
    required this.onChanged,
    required this.options,
    this.isExpandModal = false,
    this.isSearchModal = false,
    this.hintTextSearchModal,
    this.ratioHeightModal = 0.6,
    this.isOutline = true,
    this.isSmall = false,
    this.name = '',
    this.borderColor,
  })  : assert(options.length > 0),
        assert(ratioHeightModal >= 0 && ratioHeightModal <= 1),
        super(key: key);

  Widget buildHintText(ThemeData theme) {
    return Text(
      hintText ?? '',
      style: theme.textTheme.caption,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildValue(ThemeData theme, Option option) {
    TextStyle? style =
        isSmall ? theme.textTheme.bodyText2 : theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500);
    return Text(
      option.name,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildIcon(ThemeData theme) {
    Color? color = isOutline == false ? null : theme.textTheme.caption?.color;
    double size = isSmall ? 22 : 24;
    return Icon(CommunityMaterialIcons.chevron_down, size: size, color: color);
  }

  Widget buildView(
    BuildContext context, {
    required ThemeData theme,
    required Widget child,
    Option? option,
  }) {
    Color? backgroundColor = isOutline == false ? theme.colorScheme.surface : null;
    Border? border = isOutline == false ? null : Border.all(color: borderColor ?? theme.dividerColor);

    double size = isSmall ? 30 : 51;
    double radius = isSmall ? 8 : 10;
    EdgeInsetsGeometry padding = isSmall
        ? const EdgeInsetsDirectional.only(start: 14, end: 10)
        : const EdgeInsetsDirectional.only(start: 16, end: 12);
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () => clickSelect(context, option),
      child: Container(
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }

  void clickSelect(BuildContext context, [Option? option]) async {
    String? data = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);

        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * ratioHeightModal),
          padding: mediaQuery.viewInsets,
          child: ModalOptionSingleView(
            options: options,
            value: option?.key,
            onChanged: (String value) => Navigator.pop(context, value),
            isExpand: isExpandModal,
            isSearch: isSearchModal,
            hintTextSearch: hintTextSearchModal,
          ),
        );
      },
    );
    if (data != null && data != value) {
      onChanged(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Option? optionSelect = options.firstWhereOrNull((e) => e.key == value);

    // if (value?.isNotEmpty == true && optionSelect == null) {
    //   onChanged(options[0].key);
    // }

    return buildView(
      context,
      theme: theme,
      option: optionSelect,
      child: Row(
        children: [
          Expanded(
            child: optionSelect != null ? buildValue(theme, optionSelect) : buildHintText(theme),
          ), //optionSelect != null ? buildValue(theme, optionSelect) : buildHintText(theme)),
          const SizedBox(width: 12),
          buildIcon(theme),
        ],
      ),
    );
  }
}
