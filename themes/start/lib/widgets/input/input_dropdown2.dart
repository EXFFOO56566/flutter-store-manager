import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/models/option.dart';

import '../modal_option/modal_option_single_view.dart';

class InputDropdown2 extends StatelessWidget {
  final String? hintText;
  final Option? value;
  final ValueChanged<Option> onChanged;
  final List<Option> options;
  final bool isExpandModal;
  final bool isSearchModal;
  final String? hintTextSearchModal;
  final double ratioHeightModal;
  final bool isOutline;
  final Color? background;
  final bool isSmall;

  const InputDropdown2({
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
    this.background,
    this.isSmall = false,
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

  Widget buildValue(ThemeData theme) {
    TextStyle? style =
        isSmall ? theme.textTheme.bodyText2 : theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500);
    return Text(
      value?.name ?? '',
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
  }) {
    Color? backgroundColor = isOutline == false ? background ?? theme.colorScheme.surface : null;
    Border? border = isOutline == false ? null : Border.all(color: theme.dividerColor);

    double size = isSmall ? 30 : 51;
    double radius = isSmall ? 8 : 10;
    EdgeInsetsGeometry padding = isSmall
        ? const EdgeInsetsDirectional.only(start: 14, end: 10)
        : const EdgeInsetsDirectional.only(start: 16, end: 12);
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () => clickSelect(context),
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

  void clickSelect(BuildContext context) async {
    Option? data = await showModalBottomSheet<Option?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);

        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * ratioHeightModal),
          padding: mediaQuery.viewInsets,
          child: ModalOptionSingleView(
            options: options,
            value: value?.key,
            onChanged: (String key) => Navigator.pop(context, options.firstWhere((element) => element.key == key)),
            isExpand: isExpandModal,
            isSearch: isSearchModal,
            hintTextSearch: hintTextSearchModal,
          ),
        );
      },
    );
    if (data != null && data.key != value?.key) {
      onChanged(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return buildView(
      context,
      theme: theme,
      child: Row(
        children: [
          Expanded(child: value != null ? buildValue(theme) : buildHintText(theme)),
          const SizedBox(width: 12),
          buildIcon(theme),
        ],
      ),
    );
  }
}
