import 'package:flutter/material.dart';

class ElevatedColorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color background;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Size? fixedSize;
  final Size? maximumSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final AlignmentGeometry? alignment;

  const ElevatedColorButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.background,
    this.textColor,
    this.textStyle,
    this.padding,
    this.minimumSize,
    this.fixedSize,
    this.maximumSize,
    this.side,
    this.shape,
    this.alignment,
  }) : super(key: key);

  const factory ElevatedColorButton.card({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    AlignmentGeometry? alignment,
  }) = _ElevatedColorButtonCard;

  const factory ElevatedColorButton.surface({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    AlignmentGeometry? alignment,
  }) = _ElevatedColorButtonSurface;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: background,
        textStyle: textStyle,
        padding: padding,
        minimumSize: minimumSize,
        fixedSize: fixedSize,
        maximumSize: maximumSize,
        side: side,
        shape: shape,
        alignment: alignment,
      ),
      child: child,
    );
  }
}

class _ElevatedColorButtonCard extends ElevatedColorButton {
  const _ElevatedColorButtonCard({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    AlignmentGeometry? alignment,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          background: Colors.white,
          textStyle: textStyle,
          padding: padding,
          minimumSize: minimumSize,
          fixedSize: fixedSize,
          maximumSize: maximumSize,
          side: side,
          shape: shape,
          alignment: alignment,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.textTheme.subtitle1?.color,
        backgroundColor: theme.cardColor,
        textStyle: textStyle,
        padding: padding,
        minimumSize: minimumSize,
        fixedSize: fixedSize,
        maximumSize: maximumSize,
        side: side,
        shape: shape,
        alignment: alignment,
      ),
      child: child,
    );
  }
}

class _ElevatedColorButtonSurface extends ElevatedColorButton {
  const _ElevatedColorButtonSurface({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    AlignmentGeometry? alignment,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          background: Colors.white,
          textStyle: textStyle,
          padding: padding,
          minimumSize: minimumSize,
          fixedSize: fixedSize,
          maximumSize: maximumSize,
          side: side,
          shape: shape,
          alignment: alignment,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.textTheme.subtitle1?.color,
        backgroundColor: theme.colorScheme.surface,
        textStyle: textStyle,
        padding: padding,
        minimumSize: minimumSize,
        fixedSize: fixedSize,
        maximumSize: maximumSize,
        side: side,
        shape: shape,
        alignment: alignment,
      ),
      child: child,
    );
  }
}
