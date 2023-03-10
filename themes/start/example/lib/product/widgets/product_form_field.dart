import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/select_image.dart';

List<Option> _options = const [
  Option(key: '1', name: 'Shop & Search Results'),
  Option(key: '2', name: 'Shop Only'),
  Option(key: '3', name: 'Search Results Only'),
  Option(key: '4', name: 'Hidden'),
];

List<Option> _categories = const [
  Option(
    key: '1',
    name: 'Cakes',
    options: [
      Option(key: '11', name: 'Donut'),
      Option(key: '12', name: 'Pizza'),
    ],
  ),
  Option(key: '2', name: 'Vegetable'),
  Option(
    key: '3',
    name: 'Fast Food',
    options: [
      Option(key: '31', name: 'Chicken'),
      Option(key: '32', name: 'Burger'),
    ],
  ),
];

class ProductFormField extends StatefulWidget {
  const ProductFormField({Key? key}) : super(key: key);

  @override
  State<ProductFormField> createState() => _ProductFormFieldState();
}

class _ProductFormFieldState extends State<ProductFormField> {
  List<Option> _selectCategory = [];

  void clickCategories(BuildContext context) async {
    List<Option>? value = await showModalBottomSheet<List<Option>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

        return Container(
          constraints: BoxConstraints(maxHeight: height * 0.8, minHeight: height * 0.5),
          margin: mediaQuery.viewInsets,
          child: ModalOptionMultiFooterView(
            options: _categories,
            value: _selectCategory,
            onPressButton: (List<Option>? data) => Navigator.pop(context, data),
          ),
        );
      },
    );
    if (value != null && value != _selectCategory) {
      setState(() {
        _selectCategory = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputTextField(label: 'Name'),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: InputTextField(
                label: 'Regular Price',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: InputTextField(
                label: 'Sale Price',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: InputTextField(
                label: 'SKU',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: InputTextField(
                label: 'Stock Quantity',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Expanded(
              child: LabelInput(
                title: 'Manager Stock',
                padding: EdgeInsets.zero,
              ),
            ),
            CupertinoSwitch(value: true, onChanged: (_) {}),
          ],
        ),
        const SizedBox(height: 15),
        const InputTextField(
          label: 'Description',
          maxLines: 5,
        ),
        const SizedBox(height: 15),
        const SelectImage(label: 'Feature Image'),
        const SizedBox(height: 40),
        const SizedBox(height: 40),
        const LabelInput(title: 'Categories', isLarge: true),
        if (_selectCategory.isNotEmpty) ...[
          InputGroupOption(
            value: _selectCategory,
            onChanged: (List<Option> data) {
              setState(() {
                _selectCategory = data;
              });
            },
          ),
          const SizedBox(height: 20),
        ],
        Center(
          child: ElevatedColorButton.surface(
            onPressed: () => clickCategories(context),
            minimumSize: const Size(0, 41),
            padding: const EdgeInsets.symmetric(horizontal: 38),
            textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text('Select Categories'),
          ),
        ),
        const SizedBox(height: 40),
        const LabelInput(title: 'Catalog Visibility', isLarge: true),
        InputSelect(
          value: '2',
          options: _options,
          onChanged: (_) {},
        ),
        const SizedBox(height: 20),
        Text(
          'Note :  Only simple products can be created in this page. To create other product types login through the website.',
          style: theme.textTheme.overline,
        ),
      ],
    );
  }
}
