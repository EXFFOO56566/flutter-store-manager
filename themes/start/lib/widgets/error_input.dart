import 'package:flutter/material.dart';

class ErrorInput extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;

  const ErrorInput({
    Key? key,
    required this.title,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(18, 8, 18, 0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.overline?.copyWith(color: const Color(0xFFFA1616)),
      ),
    );
  }
}
