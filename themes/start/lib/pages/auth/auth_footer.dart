import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String subtitle;
  final String buttonTitle;
  final VoidCallback onPressedButton;

  const AuthFooter({
    Key? key,
    required this.subtitle,
    required this.buttonTitle,
    required this.onPressedButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subtitle,
          style: theme.textTheme.caption,
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onPressedButton,
          style: TextButton.styleFrom(
            foregroundColor: theme.textTheme.subtitle1?.color,
            textStyle: theme.textTheme.caption,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Text(buttonTitle),
        ),
      ],
    );
  }
}
