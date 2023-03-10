import 'package:flutter/material.dart';

class BackgroundDismissible extends StatelessWidget {
  final Color background;
  final IconData icon;

  const BackgroundDismissible({
    Key? key,
    required this.background,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
