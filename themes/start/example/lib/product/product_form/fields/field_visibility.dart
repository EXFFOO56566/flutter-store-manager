import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<Option> _options = const [
  Option(key: '1', name: 'Shop & Search Results'),
  Option(key: '2', name: 'Shop Only'),
  Option(key: '3', name: 'Search Results Only'),
  Option(key: '4', name: 'Hidden'),
];

class FieldVisibility extends StatefulWidget {
  const FieldVisibility({Key? key}) : super(key: key);

  @override
  State<FieldVisibility> createState() => _FieldVisibilityState();
}

class _FieldVisibilityState extends State<FieldVisibility> {
  String _selected = '1';

  @override
  Widget build(BuildContext context) {
    return InputSelect(
      value: _selected,
      options: _options,
      onChanged: (String value) => setState(() {
        _selected = value;
      }),
    );
  }
}
