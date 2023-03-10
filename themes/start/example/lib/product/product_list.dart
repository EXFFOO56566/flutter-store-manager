import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';
import 'widgets/product_list_data.dart';

List<Option> _filters = const [
  Option(key: 'a', name: 'All Products'),
  Option(key: 'b', name: 'Simple'),
  Option(key: 'c', name: 'Variable Product'),
  Option(key: 'd', name: 'Downloadable'),
  Option(key: 'e', name: 'Virtual'),
  Option(key: 'f', name: 'Grouped Product'),
  Option(key: 'g', name: 'External / Affiliate Product'),
];

class ProductListScreen extends StatefulWidget {
  static const routeName = '/product_list';

  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _type = 'a';

  void clickFilter(BuildContext context) async {
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8),
          child: ModalOptionSingleFooterView(
            options: _filters,
            value: _type,
            onPressButton: (String? text) => Navigator.pop(context, text),
          ),
        );
      },
    );
    if (value != null && value != _type) {
      setState(() {
        _type = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProductListContainer(
      title: 'All Products',
      button: ProductListButtonAdd(onPressed: () => Navigator.pushNamed(context, ProductFormScreen.routeName)),
      filter: IconButton(
        icon: const Icon(CommunityMaterialIcons.tune),
        iconSize: 20,
        onPressed: () => clickFilter(context),
      ),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: InputSearchField(hintText: 'Search product'),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  sliver: SliverToBoxAdapter(
                    child: ProductListData(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
