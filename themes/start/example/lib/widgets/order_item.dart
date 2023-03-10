import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

class OrderItem extends StatelessWidget with OrderMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const OrderItem({Key? key, this.padding, this.indentDivider, this.endIndentDivider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = false;

    return OrderItemUi(
      icon: buildIcon(theme: theme),
      orderId: buildId(text: '#3242', theme: theme, isLoading: loading),
      status: buildStatus(text: 'Processcing', theme: theme, isLoading: loading),
      dateTimeUser: buildDateTimeUser(date: '29/10/2019', time: '10:00 AM', theme: theme, isLoading: loading),
      info: const Text('info'),
      padding: padding,
      indentDivider: indentDivider ?? 44,
      endIndentDivider: endIndentDivider,
      onTap: () => Navigator.pushNamed(context, OrderDetailScreen.routeName),
    );
  }
}
