import 'package:flutter/material.dart';

class LoginMobileCode extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final Widget form;
  const LoginMobileCode({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 9),
        subtitle,
        const SizedBox(height: 33),
        form,
      ],
    );
  }
}
