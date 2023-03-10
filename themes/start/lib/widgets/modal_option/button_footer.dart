import 'package:flutter/material.dart';

class ButtonFooter extends StatelessWidget {
  final String text;
  final VoidCallback onPressedText;
  final String? textSecondary;
  final VoidCallback? onPressedTextSecondary;
  final EdgeInsetsGeometry? padding;

  const ButtonFooter({
    Key? key,
    required this.text,
    required this.onPressedText,
    this.textSecondary,
    this.onPressedTextSecondary,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          if (onPressedTextSecondary != null) ...[
            Expanded(
              child: ElevatedButton(
                onPressed: onPressedTextSecondary,
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.textTheme.subtitle1?.color,
                  backgroundColor: theme.colorScheme.surface,
                  padding: EdgeInsets.zero,
                ),
                child: Text(textSecondary ?? 'Text'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: ElevatedButton(
              onPressed: onPressedText,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
