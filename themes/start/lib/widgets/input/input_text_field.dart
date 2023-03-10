import 'package:flutter/material.dart';
import 'package:ui/widgets/label_input.dart';

class InputTextField extends StatelessWidget {
  final String? label;
  final Widget? trailingLabel;
  final bool isRequired;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final Color? cursorColor;
  final TextInputAction? textInputAction;

  const InputTextField({
    Key? key,
    this.label,
    this.trailingLabel,
    this.isRequired = false,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.decoration,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.maxLength,
    this.cursorColor,
    this.textInputAction,
  }) : super(key: key);

  Widget buildInputLine() {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: decoration,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      maxLength: maxLength,
      cursorColor: cursorColor,
      textInputAction: textInputAction,
    );
  }

  Widget buildInput() {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: decoration,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLength: maxLength,
      cursorColor: cursorColor,
      textInputAction: textInputAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget input = maxLines != null || minLines != null ? buildInputLine() : buildInput();
    if (label?.isNotEmpty == true || trailingLabel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelInput(title: label ?? '', isRequired: isRequired, trailing: trailingLabel),
          input,
        ],
      );
    }
    return input;
  }
}
