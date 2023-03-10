import 'package:flutter/material.dart';

class InputRadio extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const InputRadio({
    Key? key,
    this.value = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color? color = value ? theme.primaryColor : theme.textTheme.caption?.color;

    Widget child = Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(border: Border.all(color: color ?? theme.dividerColor), shape: BoxShape.circle),
      alignment: Alignment.center,
      child: value
          ? Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            )
          : null,
    );
    if (onChanged != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onChanged?.call(!value),
        child: child,
      );
    }
    return child;
  }
}
