import 'package:flutter/material.dart';

class OrderDetailProductItem extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget price;
  final Widget? attribute;
  final Widget total;

  const OrderDetailProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.total,
    this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [name]),
                      ),
                      const SizedBox(width: 16),
                      price,
                    ],
                  ),
                  if (attribute != null) ...[
                    attribute ?? Container(),
                    const SizedBox(height: 4),
                  ],
                  total,
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, thickness: 1)
      ],
    );
  }
}
