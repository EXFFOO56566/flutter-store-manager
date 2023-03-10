import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldDescription extends StatelessWidget {
  const FieldDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(
      label: 'Description',
      minLines: 5,
    );
  }
}
