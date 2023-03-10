import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldName extends StatelessWidget {
  const FieldName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(label: 'Name');
  }
}
