import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String subTitle;

  const AccountTile({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.overline),
        Text(subTitle, style: theme.textTheme.bodyText2),
      ],
    );
  }
}
