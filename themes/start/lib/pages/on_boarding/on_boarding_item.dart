import 'package:flutter/material.dart';

class OnBoardingItem extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final double padImage;
  final double padText;

  const OnBoardingItem({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.padImage = 40,
    this.padText = 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
          child: image,
        ),
        SizedBox(height: padImage),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headline6,
        ),
        SizedBox(height: padText),
        Container(
          constraints: const BoxConstraints(maxWidth: 262),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.caption,
          ),
        )
      ],
    );
  }
}
