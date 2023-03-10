import 'package:flutter/material.dart';

class BoxDividerUi extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? heightDivider;
  final double? indentDivider;
  final double? endIndentDivider;
  final Color? color;
  final Widget? child;

  const BoxDividerUi({
    Key? key,
    this.child,
    this.padding,
    this.color,
    this.heightDivider,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: padding ?? EdgeInsets.zero, child: child),
        Divider(
          color: color,
          indent: indentDivider,
          endIndent: endIndentDivider,
          height: heightDivider ?? 1,
          thickness: heightDivider ?? 1,
        ),
      ],
    );
  }
}
