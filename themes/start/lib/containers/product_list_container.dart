import 'package:flutter/material.dart';
import 'package:ui/mixins/mixins.dart';

class ProductListContainer extends StatelessWidget with AppbarMixin {
  final String title;
  final Widget child;
  final Widget button;
  final Widget? filter;

  const ProductListContainer({
    Key? key,
    required this.title,
    required this.child,
    required this.button,
    this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title, style: theme.textTheme.headline6),
        actions: [
          filter ?? Container(),
          const SizedBox(width: 8),
        ],
        centerTitle: false,
        titleSpacing: 25,
      ),
      extendBody: true,
      bottomNavigationBar: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: button,
        ),
      ),
      body: child,
    );
  }
}
