import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

class ModalOptionApply extends StatefulWidget {
  final List<Option> options;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? textButton;
  final bool isExpand;

  const ModalOptionApply({
    Key? key,
    required this.options,
    required this.onChanged,
    this.value,
    this.textButton,
    this.isExpand = false,
  }) : super(key: key);

  @override
  State<ModalOptionApply> createState() => _ModalOptionApplyState();
}

class _ModalOptionApplyState extends State<ModalOptionApply> {
  String? _value;

  @override
  void initState() {
    _value = widget.value;
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
    ThemeData theme = Theme.of(context);

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
                  bool isSelect = option.key == _value;

                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          option.name,
                          style: theme.textTheme.bodyText2?.copyWith(color: isSelect ? theme.primaryColor : null),
                        ),
                        trailing: isSelect ? Icon(CommunityMaterialIcons.check, color: theme.primaryColor) : null,
                        contentPadding: EdgeInsets.zero,
                        onTap: () => setState(() {
                          _value = option.key;
                        }),
                      ),
                      const Divider(height: 1, thickness: 1),
                    ],
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
