import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

class AuthSocials extends StatelessWidget {
  final bool isLoginApple;
  final Function(String type) handleSocial;

  const AuthSocials({
    Key? key,
    this.isLoginApple = false,
    required this.handleSocial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Wrap(
      spacing: 19,
      runSpacing: 12,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.surface,
          ),
          width: 48,
          height: 48,
          child: IconButton(
            icon: const Icon(FontAwesomeIcons.facebook),
            iconSize: 20,
            onPressed: () => handleSocial('facebook'),
            color: const Color(0xFF0B69FF),
            splashRadius: 24,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.surface,
          ),
          width: 48,
          height: 48,
          child: IconButton(
            icon: const Icon(FontAwesomeIcons.googlePlus),
            iconSize: 20,
            onPressed: () => handleSocial('google'),
            color: const Color(0xFFFA1616),
            splashRadius: 24,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.surface,
          ),
          width: 48,
          height: 48,
          child: IconButton(
            icon: const Icon(FontAwesomeIcons.solidComments),
            iconSize: 20,
            onPressed: () => handleSocial('sms'),
            color: theme.textTheme.subtitle1?.color,
            splashRadius: 24,
          ),
        ),
        if (isLoginApple)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface,
            ),
            width: 48,
            height: 48,
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.apple),
              iconSize: 20,
              onPressed: () => handleSocial('apple'),
              color: theme.textTheme.subtitle1?.color,
              splashRadius: 24,
            ),
          ),
      ],
    );
  }
}
