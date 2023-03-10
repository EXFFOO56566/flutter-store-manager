import 'package:flutter/material.dart';

class ListContent extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const ListContent({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true) ...[
          Text(
            title!,
            style: theme.textTheme.subtitle2?.copyWith(color: theme.textTheme.caption?.color),
          ),
          const SizedBox(height: 21),
        ],
        ...children,
      ],
    );
  }
}
