import 'package:flutter/material.dart';

import '../../models/option.dart';
import 'input_radio.dart';

class InputSelect extends StatelessWidget {
  final String? value;
  final ValueChanged<String> onChanged;
  final List<Option> options;

  const InputSelect({
    Key? key,
    required this.options,
    required this.onChanged,
    this.value,
  })  : assert(options.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.surface),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemBuilder: (_, int index) {
          Option item = options[index];
          return GestureDetector(
            onTap: () => onChanged(item.key),
            child: Row(
              children: [
                InputRadio(
                  value: item.key == value,
                  onChanged: (_) => onChanged(item.key),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.name,
                    style: theme.textTheme.caption?.copyWith(color: item.key == value ? theme.primaryColor : null),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, int index) => const SizedBox(height: 10),
        itemCount: options.length,
      ),
    );
  }
}
