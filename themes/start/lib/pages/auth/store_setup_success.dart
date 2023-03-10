import 'package:flutter/material.dart';

class StoreSetupSuccess extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget button;

  const StoreSetupSuccess({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/store_setup_success.png',
          width: double.infinity,
          package: 'ui',
        ),
        const SizedBox(height: 40),
        Text(title, style: theme.textTheme.headline6),
        const SizedBox(height: 19),
        Text(
          subtitle,
          style: theme.textTheme.caption,
        ),
        const SizedBox(height: 40),
        Center(child: button),
      ],
    );
  }
}
