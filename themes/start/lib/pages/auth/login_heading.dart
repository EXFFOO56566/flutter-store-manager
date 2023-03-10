import 'package:flutter/material.dart';

class LoginHeading extends StatelessWidget {
  final String? title;
  final Widget logo;

  const LoginHeading({
    Key? key,
    this.title,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        logo,
        const SizedBox(height: 20),
        Text(title ?? 'Welcome', style: theme.textTheme.headline5),
        const SizedBox(height: 19),
        Image.asset('assets/images/line.png', package: 'ui'),
      ],
    );
  }
}
