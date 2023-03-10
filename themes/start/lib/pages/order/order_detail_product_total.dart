import 'package:flutter/material.dart';
import 'package:ui/widgets/container_secondary.dart';

class OrderDetailProductTotal extends StatelessWidget {
  final Widget product;
  final Widget? total;
  const OrderDetailProductTotal({
    Key? key,
    required this.product,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.surface),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ContainerSecondary(child: product),
          ),
          if (total != null) Padding(padding: const EdgeInsets.fromLTRB(20, 24, 20, 20), child: total),
        ],
      ),
    );
  }
}
