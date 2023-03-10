import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'variable_container.dart';
import 'variant_form.dart';

List<Option> _attributeOptions = const [
  Option(key: 'a', name: 'Any attr'),
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
];

List<Option> _variationOptions = const [
  Option(key: 'a', name: 'Choose option'),
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
];

class VariationForm extends StatelessWidget {
  const VariationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return VariableContainer(
      children: [
        const LabelInput(
          title: 'Default Values',
          padding: EdgeInsets.only(bottom: 8),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        const LabelInput(
          title: 'Variations Bulk Options',
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        InputDropdown(
          value: 'a',
          options: _variationOptions,
          onChanged: (_) {},
        ),
        const Divider(height: 48, thickness: 1),
        const VariantForm(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 41),
            textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
            padding: const EdgeInsets.symmetric(horizontal: 38),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add Variant'),
        ),
      ],
    );
  }
}
