import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldSalePrice extends StatelessWidget {
  const FieldSalePrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(label: 'Sale Price');
  }
}
