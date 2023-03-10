import 'package:flutter/material.dart';

class ModalOptionContainer extends StatelessWidget {
  final Widget? search;
  final Widget child;
  final Widget? footer;
  final bool isExpand;
  final EdgeInsetsGeometry? padding;

  const ModalOptionContainer({
    Key? key,
    required this.child,
    this.search,
    this.footer,
    this.isExpand = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = isExpand ? Expanded(child: child) : Flexible(child: child);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                search ?? Container(),
                content,
              ],
            ),
          ),
          footer ?? Container(),
        ],
      ),
    );
  }
}
