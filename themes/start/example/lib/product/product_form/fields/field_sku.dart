import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldSku extends StatelessWidget {
  const FieldSku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(label: 'SKU');
  }
}
