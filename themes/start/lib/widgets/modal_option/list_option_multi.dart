import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';
import 'package:ui/widgets/animated_shimmer.dart';

List<Option> flattenOption({required List<Option> data}) {
  if (data.isEmpty) return data;

  List<Option> result = <Option>[];

  result = data
      .expand(
        (value) => [
          Option(key: value.key, name: value.name, options: []),
          ...flattenOption(data: value.options ?? []),
        ],
      )
      .toList();

  return result;
}

class ListOptionMulti extends StatelessWidget {
  final List<Option> data;
  final List<Option>? keysSelected;
  final ValueChanged<Option> clickSelect;
  final EdgeInsetsGeometry? padding;
  final Widget? heading;

  const ListOptionMulti({
    Key? key,
    required this.data,
    required this.clickSelect,
    this.keysSelected,
    this.padding,
    this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading ?? Container(),
          ...List.generate(
            data.length,
            (index) {
              Option option = data[index];
              return ItemOption(
                option: option,
                selectOptions: keysSelected ?? [],
                onClick: (value) => clickSelect(value),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemOption extends StatefulWidget {
  final Option option;
  final List<Option> selectOptions;
  final ValueChanged<Option> onClick;

  const ItemOption({
    Key? key,
    required this.option,
    required this.onClick,
    required this.selectOptions,
  }) : super(key: key);

  @override
  State<ItemOption> createState() => _ItemOptionState();
}

class _ItemOptionState extends State<ItemOption> {
  late bool _showChild;

  @override
  void initState() {
    List<Option> childOptions = flattenOption(data: widget.option.options ?? []);
    if (childOptions.isEmpty) {
      _showChild = false;
    } else {
      int visit =
          widget.selectOptions.indexWhere((element) => childOptions.indexWhere((e) => e.key == element.key) > -1);
      _showChild = visit > -1;
    }
    super.initState();
  }

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

    int visit = widget.selectOptions.indexWhere((element) => element.key == widget.option.key);
    bool isSelect = visit > -1;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            isSelect ? CommunityMaterialIcons.checkbox_marked : CommunityMaterialIcons.checkbox_blank_outline,
            color: getColorIconCheck(
              theme: theme,
              enable: widget.option.enabled,
              selected: isSelect,
            ),
            size: 22,
          ),
          title: Text(
            widget.option.name,
            style: theme.textTheme.bodyText2?.copyWith(
                color: getColor(
              theme: theme,
              enable: widget.option.enabled,
              selected: isSelect,
            )),
          ),
          trailing: widget.option.options?.isNotEmpty == true
              ? InkResponse(
                  onTap: widget.option.enabled
                      ? () => setState(() {
                            _showChild = !_showChild;
                          })
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Icon(
                      _showChild ? CommunityMaterialIcons.chevron_down : CommunityMaterialIcons.chevron_right,
                      size: 22,
                      color: getColor(
                        theme: theme,
                        enable: widget.option.enabled,
                        selected: isSelect,
                      ),
                    ),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          horizontalTitleGap: 9,
          enabled: widget.option.enabled,
          onTap: () => widget.onClick(widget.option),
        ),
        const Divider(height: 1, thickness: 1),
        if (widget.option.options?.isNotEmpty == true && _showChild)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.option.options!.length,
                (index) => ItemOption(
                  option: widget.option.options![index],
                  selectOptions: widget.selectOptions,
                  onClick: widget.onClick,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class ItemOptionLoading extends StatelessWidget {
  const ItemOptionLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          title: AnimatedShimmer(width: 200, height: 16, radius: 10),
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          horizontalTitleGap: 9,
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}
