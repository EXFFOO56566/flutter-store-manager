import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  static const routeName = '/product_list';
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Product list'),
      ),
    );
  }
}
