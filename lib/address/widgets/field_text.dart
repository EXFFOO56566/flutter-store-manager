import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

class FieldText extends StatelessWidget {
  final Map field;
  final String? initData;
  final bool isRequired;
  final ValueChanged<String>? onChanged;

  const FieldText({
    Key? key,
    required this.field,
    this.initData,
    this.onChanged,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = field['label'] ?? 'Field';
    bool required = field['required'] ?? false;

    return InputTextField(
      label: label,
      initialValue: initData ?? "",
      isRequired: isRequired ? required : false,
      onChanged: onChanged,
    );
  }
}
