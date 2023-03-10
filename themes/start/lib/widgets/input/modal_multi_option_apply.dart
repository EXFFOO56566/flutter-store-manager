import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

class ModalMultiOptionApply extends StatefulWidget {
  final List<Option> options;
  final List<Option>? value;
  final ValueChanged<List<Option>> onChanged;
  final String? textButton;
  final bool isExpand;

  const ModalMultiOptionApply({
    Key? key,
    required this.options,
    required this.onChanged,
    this.value,
    this.textButton,
    this.isExpand = false,
  }) : super(key: key);

  @override
  State<ModalMultiOptionApply> createState() => _ModalMultiOptionApplyState();
}

class _ModalMultiOptionApplyState extends State<ModalMultiOptionApply> {
  late List<Option> _value;

  @override
  void initState() {
    _value = [
      ...widget.value ?? [],
    ];
    super.initState();
  }

  Widget buildView({required Widget child}) {
    if (widget.isExpand) {
      return Expanded(child: child);
    }
    return Flexible(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildView(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
            child: Column(
              children: List.generate(
                widget.options.length,
                (index) {
                  Option option = widget.options[index];

                  return _ItemOption(
                    option: option,
                    selectOptions: _value,
                    onClick: (data) => setState(() {
                      int visit = _value.indexWhere((element) => element.key == data.key);
                      bool isSelect = visit > -1;
                      if (isSelect) {
                        _value.removeAt(visit);
                      } else {
                        _value.add(Option(key: data.key, name: data.name));
                      }
                    }),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          child: ElevatedButton(
            onPressed: () => widget.onChanged(_value),
            child: Text(widget.textButton ?? 'Apply'),
          ),
        )
      ],
    );
  }
}

class _ItemOption extends StatefulWidget {
  final Option option;
  final List<Option> selectOptions;
  final ValueChanged<Option> onClick;

  const _ItemOption({
    Key? key,
    required this.option,
    required this.onClick,
    required this.selectOptions,
  }) : super(key: key);

  @override
  _ItemOptionState createState() => _ItemOptionState();
}

class _ItemOptionState extends State<_ItemOption> {
  bool _showChild = false;

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
            color: isSelect ? theme.primaryColor : theme.textTheme.caption?.color,
            size: 22,
          ),
          title: Text(
            widget.option.name,
            style: theme.textTheme.bodyText2?.copyWith(color: isSelect ? theme.primaryColor : null),
          ),
          trailing: widget.option.options?.isNotEmpty == true
              ? InkResponse(
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Icon(
                      _showChild ? CommunityMaterialIcons.chevron_down : CommunityMaterialIcons.chevron_right,
                      size: 22,
                    ),
                  ),
                  onTap: () => setState(() {
                    _showChild = !_showChild;
                  }),
                )
              : null,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          horizontalTitleGap: 9,
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
                (index) => _ItemOption(
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
