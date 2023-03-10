import 'package:flutter/material.dart';

class InputSearchField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;

  const InputSearchField({
    Key? key,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    InputBorder? border = theme.inputDecorationTheme.border?.copyWith(borderSide: BorderSide.none);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: theme.textTheme.caption?.color,
        ),
        hintText: hintText,
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: border,
        enabledBorder: border,
      ),
      keyboardType: keyboardType,
    );
  }
}
