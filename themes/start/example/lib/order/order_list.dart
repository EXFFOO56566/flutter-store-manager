import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/order_list_data.dart';

List<Option> _filters = const [
  Option(key: 'a', name: 'All Orders'),
  Option(key: 'b', name: 'Completed'),
  Option(key: 'c', name: 'Pending Payment'),
  Option(key: 'd', name: 'Processing'),
  Option(key: 'e', name: 'On Hold'),
  Option(key: 'f', name: 'Cancelled'),
  Option(key: 'g', name: 'Refunded'),
];

class OrderListScreen extends StatefulWidget {
  static const routeName = '/order_list';

  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
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
    return OrderListContainer(
      title: 'Orders',
      filter: IconButton(
        icon: const Icon(CommunityMaterialIcons.tune),
        iconSize: 20,
        onPressed: () => clickFilter(context),
      ),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: InputSearchField(hintText: 'Search Order'),
          ),
          Expanded(child: OrderListData()),
        ],
      ),
    );
  }
}
