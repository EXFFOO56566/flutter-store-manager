import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return OrderDetailProductItem(
      image: const Text('image'),
      name: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          textStyle: theme.textTheme.bodyText2,
        ),
        child: const Text('Test Product'),
      ),
      price: Text('\$ 299  x1', style: theme.textTheme.bodyText2),
      total: const Text('total'),
    );
  }
}
