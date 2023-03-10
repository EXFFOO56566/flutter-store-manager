import 'package:flutter/material.dart';

class ButtonRichText extends StatelessWidget {
  final String subTitle;
  final String title;
  final GestureTapCallback? onTap;

  const ButtonRichText({
    Key? key,
    required this.title,
    required this.subTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? style = theme.textTheme.caption;

    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: subTitle,
          children: [
            TextSpan(
              text: title,
              style: TextStyle(color: theme.primaryColor),
            ),
          ],
          style: style,
        ),
      ),
    );
  }
}
