import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class MediaListBottom extends StatelessWidget {
  final Widget title;
  final Widget action;

  const MediaListBottom({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ContainerSecondary(
      color: theme.cardColor,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          offset: Offset(0, -5),
          blurRadius: 10,
          spreadRadius: 0,
        ),
      ],
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 25),
      child: Row(
        children: [Expanded(child: title), const SizedBox(width: 16), action],
      ),
    );
  }
}
