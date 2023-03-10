import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class ProductItemUi extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget price;
  final Widget type;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const ProductItemUi({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.type,
    this.dividerColor,
    this.indentDivider,
    this.endIndentDivider,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: BoxDividerUi(
        padding: padding,
        color: dividerColor,
        indentDivider: indentDivider,
        endIndentDivider: endIndentDivider,
        heightDivider: 1,
        child: Row(
          children: [
            image,
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  name,
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          price,
                        ],
                      )),
                      const SizedBox(width: 12),
                      type,
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
