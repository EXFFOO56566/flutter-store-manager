import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FieldStockQuantity extends StatelessWidget {
  const FieldStockQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InputTextField(label: 'Stock Quantity');
  }
}
