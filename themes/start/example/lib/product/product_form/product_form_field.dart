import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'product_form_simple.dart';
import 'product_form_variable.dart';
import 'product_form_group.dart';
import 'product_form_external.dart';

List<Option> _types = const [
  Option(key: '1', name: 'Simple Product'),
  Option(key: '2', name: 'Variable Product'),
  Option(key: '3', name: 'Grouped Product'),
  Option(key: '4', name: 'External/Affiliate Product'),
];

class ProductFormField extends StatefulWidget {
  const ProductFormField({Key? key}) : super(key: key);

  @override
  State<ProductFormField> createState() => _ProductFormFieldState();
}

class _ProductFormFieldState extends State<ProductFormField> {
  String _type = '1';

  Widget buildView() {
    switch (_type) {
      case '4':
        return const ProductFormExternal();
      case '3':
        return const ProductFormGroup();
      case '2':
        return const ProductFormVariable();
      default:
        return const ProductFormSimple();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputDropdown(
          value: _type,
          options: _types,
          onChanged: (String value) => setState(() {
            _type = value;
          }),
        ),
        const SizedBox(height: 15),
        buildView(),
      ],
    );
  }
}
