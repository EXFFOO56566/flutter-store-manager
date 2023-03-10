import 'package:flutter/material.dart';

class ContainerSecondary extends StatelessWidget {
  final Widget? child;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxConstraints? constraints;

  const ContainerSecondary({
    Key? key,
    this.child,
    this.height,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surface,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
