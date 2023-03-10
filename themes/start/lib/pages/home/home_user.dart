import 'package:flutter/material.dart';

class HomeUser extends StatelessWidget {
  final String title;
  final String time;
  final Widget avatar;

  const HomeUser({
    Key? key,
    required this.title,
    required this.time,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headline6,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(time, style: theme.textTheme.caption),
            ],
          ),
        ),
        const SizedBox(width: 20),
        avatar,
      ],
    );
  }
}
