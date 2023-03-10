import 'package:flutter/material.dart';

class FixedBottom extends StatelessWidget {
  final Widget bottom;
  final Widget child;
  final EdgeInsetsGeometry? paddingBottom;

  const FixedBottom({
    Key? key,
    required this.bottom,
    required this.child,
    this.paddingBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: child),
        Container(
          width: double.infinity,
          padding: paddingBottom,
          child: bottom,
        )
      ],
    );
  }
}
