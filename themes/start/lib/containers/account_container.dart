import 'package:flutter/material.dart';

class AccountContainer extends StatelessWidget {
  final Widget content;
  final Widget button;
  final EdgeInsetsGeometry? padding;

  const AccountContainer({
    Key? key,
    required this.content,
    required this.button,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            content,
            const SizedBox(height: 40),
            button,
          ],
        ),
      ),
    );
  }
}
