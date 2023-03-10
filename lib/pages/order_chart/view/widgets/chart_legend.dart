// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class _LegendItem extends StatelessWidget {
  final Color color;
  final String content;

  const _LegendItem({
    Key? key,
    required this.color,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            content,
            style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
          ),
        )
      ],
    );
  }
}

buildLegendChartOrder(TranslateType translate) {
  var listLineName = [
    translate('chart:text_gross_sales'),
    translate('chart:text_earning'),
    translate('chart:text_refund'),
    translate('chart:text_tax_amounts'),
    translate('chart:text_shipping_amounts'),
    translate('chart:text_order_count'),
    translate('chart:text_withdrawal'),
  ];
  return GridView.count(
    childAspectRatio: 7,
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: List.generate(
        7,
        (index) => _LegendItem(
              color: ColorBlock.listChartColor[index][0],
              content: listLineName[index],
            )),
  );
}
