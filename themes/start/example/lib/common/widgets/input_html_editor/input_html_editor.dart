import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'input_html_editor_page.dart';

class InputHtmlEditor extends StatefulWidget {
  final String? label;
  final String? value;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  const InputHtmlEditor({
    Key? key,
    this.label,
    this.value,
    required this.onChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  State<InputHtmlEditor> createState() => _InputHtmlEditorState();
}

class _InputHtmlEditorState extends State<InputHtmlEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value ?? '');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputHtmlEditor oldWidget) {
    _controller.text = widget.value ?? "";
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      focusNode: widget.focusNode,
      label: widget.label,
      controller: _controller,
      trailingLabel: _ButtonHtmlEditor(
        onChanged: (value) {
          if (value != widget.value) {
            _controller.text = value;
            widget.onChanged(value);
          }
        },
        value: widget.value,
      ),
      onChanged: (value) {
        if (value != widget.value) {
          widget.onChanged(value);
        }
      },
      maxLines: 5,
    );
  }
}

class _ButtonHtmlEditor extends StatelessWidget {
  final String? value;
  final ValueChanged<String> onChanged;

  const _ButtonHtmlEditor({
    Key? key,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  void clickPageEditHtml(BuildContext context) async {
    String? data = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return InputHtmlEditorPage(
            initValue: value,
            onChanged: (String newValue) {
              Navigator.pop(context, newValue);
            },
          );
        },
        fullscreenDialog: true,
      ),
    );
    if (data is String && data != value) {
      onChanged(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextButton(
      onPressed: () => clickPageEditHtml(context),
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        textStyle: theme.textTheme.bodyText2,
        padding: EdgeInsets.zero,
      ),
      child: const Text("Edit"),
    );
  }
}
