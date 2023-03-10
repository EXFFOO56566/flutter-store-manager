import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

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

class FieldCategory extends StatefulWidget {
  const FieldCategory({Key? key}) : super(key: key);

  @override
  State<FieldCategory> createState() => _FieldCategoryState();
}

class _FieldCategoryState extends State<FieldCategory> {
  List<Option> _selectCategory = [];

  void clickCategories(BuildContext context) async {
    List<Option>? value = await showModalBottomSheet<List<Option>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8, minHeight: mediaQuery.size.height * 0.5),
          child: ModalMultiOptionApply(
            options: _categories,
            value: _selectCategory,
            onChanged: (List<Option> data) => Navigator.pop(context, data),
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
      ],
    );
  }
}
