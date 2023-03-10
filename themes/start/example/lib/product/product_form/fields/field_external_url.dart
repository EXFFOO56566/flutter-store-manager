import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldExternalUrl extends StatelessWidget {
  const FieldExternalUrl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(label: 'URL');
  }
}
