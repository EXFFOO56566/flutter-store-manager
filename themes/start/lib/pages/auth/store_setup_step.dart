import 'package:flutter/material.dart';

class StoreSetupStep extends StatelessWidget {
  final List<String> items;
  final int currentStep;
  final EdgeInsetsGeometry? padding;

  const StoreSetupStep({
    Key? key,
    required this.items,
    this.currentStep = 0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: List.generate(items.length, (index) {
          bool selected = currentStep >= index;
          bool previewSelected = currentStep > index - 1;
          bool nextSelected = currentStep >= index + 1;
          String visit = 'center';
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

          if (index == 0) {
            visit = 'start';
            crossAxisAlignment = CrossAxisAlignment.start;
          }

          if (index == items.length - 1) {
            visit = 'end';
            crossAxisAlignment = CrossAxisAlignment.end;
          }

          Color? textColor = selected ? theme.primaryColor : theme.textTheme.caption?.color;

          return Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                _DividerLine(
                  visit: visit,
                  selected: selected,
                  previewSelected: previewSelected,
                  nextSelected: nextSelected,
                ),
                const SizedBox(height: 5),
                Text(
                  items[index],
                  style: theme.textTheme.bodyText2?.copyWith(color: textColor),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  final String visit;
  final bool selected;
  final bool previewSelected;
  final bool nextSelected;

  const _DividerLine({
    Key? key,
    this.visit = 'center',
    this.selected = false,
    this.previewSelected = false,
    this.nextSelected = false,
  }) : super(key: key);

  Widget buildDivider(Color color) {
    return Divider(height: 4, thickness: 4, color: color);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color backgroundColor = selected ? theme.primaryColorLight : Colors.transparent;
    Color? borderColor = selected ? theme.primaryColor : theme.textTheme.caption?.color;
    return Row(
      children: [
        if (visit != 'start')
          Expanded(
            child: buildDivider(previewSelected ? theme.primaryColor : theme.dividerColor),
          ),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: borderColor ?? theme.dividerColor),
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
        ),
        if (visit != 'end')
          Expanded(
            child: buildDivider(nextSelected ? theme.primaryColor : theme.dividerColor),
          ),
      ],
    );
  }
}
