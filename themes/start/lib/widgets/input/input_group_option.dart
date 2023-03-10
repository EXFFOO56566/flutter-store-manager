import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';
import 'package:ui/widgets/elevated_color_button.dart';

class InputGroupOption extends StatelessWidget {
  final List<Option> value;
  final ValueChanged<List<Option>> onChanged;
  final Widget? trailing;
  final double? minHeight;

  const InputGroupOption({
    Key? key,
    required this.value,
    required this.onChanged,
    this.trailing,
    this.minHeight,
  }) : super(key: key);

  Widget buildItem(Option option, ThemeData theme) {
    return ElevatedColorButton.card(
      onPressed: () => onChanged(value.where((element) => element.key != option.key).toList()),
      textStyle: theme.textTheme.bodyText2,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      minimumSize: const Size(0, 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(option.name),
          const SizedBox(width: 10),
          const Icon(CommunityMaterialIcons.close_circle, size: 14),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...List.generate(value.length, (index) => buildItem(value[index], theme)),
              ],
            ),
          ),
          trailing ?? Container(),
        ],
      ),
    );
  }
}
