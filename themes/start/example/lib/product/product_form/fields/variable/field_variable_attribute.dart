import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'field_option.dart';

class FieldVariableAttribute extends StatelessWidget {
  const FieldVariableAttribute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionView(
      title: const Text('Attribute'),
      isSecondary: true,
      expandedAlignment: AlignmentDirectional.topStart,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.only(top: 16, bottom: 8),
      children: [
        ...List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: index < 2 ? const FieldVariableOptionTerm() : const FieldVariableOptionCustom(),
          );
        }),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 41),
            textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
            padding: const EdgeInsets.symmetric(horizontal: 38),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add Attribute'),
        ),
      ],
    );
  }
}
