import 'package:flutter/material.dart';
import 'package:ui/mixins/mixins.dart';

class OrderListContainer extends StatelessWidget with AppbarMixin {
  final String title;
  final Widget child;
  final Widget? filter;
  final bool? disabledFilter;

  const OrderListContainer({
    Key? key,
    required this.title,
    required this.child,
    this.filter,
    this.disabledFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title, style: theme.textTheme.headline6),
        actions: [
          if (disabledFilter == true) ...[
            filter ?? Container(),
            const SizedBox(width: 8),
          ],
        ],
        centerTitle: false,
        titleSpacing: 25,
      ),
      body: child,
    );
  }
}
