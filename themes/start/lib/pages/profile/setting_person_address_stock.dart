import 'package:flutter/material.dart';

class SettingPersonAddressStock extends StatelessWidget {
  final String? title;
  final Widget switchWidget;

  const SettingPersonAddressStock({Key? key, this.title, required this.switchWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? 'Manager Stock',
            style: theme.textTheme.caption,
          ),
        ),
        switchWidget,
      ],
    );
  }
}
