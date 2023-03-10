import 'package:flutter/material.dart';

class LabelInput extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLarge;
  final bool isRequired;

  const LabelInput({
    Key? key,
    required this.title,
    this.trailing,
    this.padding,
    this.isLarge = false,
    this.isRequired = false,
  }) : super(key: key);

  Widget buildContent({
    required String value,
    bool requiredValue = false,
    TextStyle? style,
    required Color colorRequired,
  }) {
    Widget text = RichText(
      text: TextSpan(
        text: value,
        children: [
          if (requiredValue) ...[TextSpan(text: ' *', style: TextStyle(color: colorRequired))]
        ],
        style: style,
      ),
    );
    if (trailing != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Flexible(child: text), const SizedBox(width: 16), trailing ?? Container()],
      );
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (isLarge) {
      return Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 10),
        child: buildContent(
          value: title,
          requiredValue: isRequired,
          style: theme.textTheme.subtitle2,
          colorRequired: theme.colorScheme.error,
        ),
      );
    }
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 4),
      child: buildContent(
        value: title,
        requiredValue: isRequired,
        style: theme.textTheme.caption,
        colorRequired: theme.colorScheme.error,
      ),
    );
  }
}

class LabelView extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLarge;
  final bool isRequired;
  final Widget child;
  const LabelView({
    Key? key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
    this.isLarge = true,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInput(
          title: title,
          trailing: trailing,
          isLarge: isLarge,
          isRequired: isRequired,
          padding: const EdgeInsets.only(bottom: 19),
        ),
        child,
      ],
    );
  }
}
