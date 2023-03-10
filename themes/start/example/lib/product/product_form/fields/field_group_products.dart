import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<Option> _products = const [
  Option(
    key: '1',
    name: 'Name 1',
    options: [
      Option(key: '11', name: 'Name 11'),
      Option(key: '12', name: 'Name 12'),
    ],
  ),
  Option(key: '2', name: 'Name 2'),
  Option(
    key: '3',
    name: 'Name 3',
    options: [
      Option(key: '31', name: 'Name 31'),
      Option(key: '32', name: 'Name 32'),
    ],
  ),
];

class FieldGroupProducts extends StatefulWidget {
  const FieldGroupProducts({Key? key}) : super(key: key);

  @override
  State<FieldGroupProducts> createState() => _FieldGroupProductsState();
}

class _FieldGroupProductsState extends State<FieldGroupProducts> {
  List<Option> _selectProduct = [];

  void clickProducts(BuildContext context) async {
    List<Option>? value = await showModalBottomSheet<List<Option>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8, minHeight: mediaQuery.size.height * 0.5),
          child: ModalMultiOptionApply(
            options: _products,
            value: _selectProduct,
            isExpand: true,
            onChanged: (List<Option> data) => Navigator.pop(context, data),
            textButton: 'Save',
          ),
        );
      },
    );

    if (value != null && value != _selectProduct) {
      setState(() {
        _selectProduct = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelInput(
          title: 'Grouped products',
        ),
        InputGroupOption(
          value: _selectProduct,
          onChanged: (List<Option> data) => setState(() {
            _selectProduct = data;
          }),
          trailing: InkResponse(
            onTap: () => clickProducts(context),
            child: const Icon(CommunityMaterialIcons.chevron_right),
          ),
        )
      ],
    );
  }
}
