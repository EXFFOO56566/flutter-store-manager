import 'package:flutter/material.dart';

class ReviewDetailContainer extends StatelessWidget {
  final Widget content;
  final Widget buttonBottom;

  const ReviewDetailContainer({
    Key? key,
    required this.content,
    required this.buttonBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: content),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: buttonBottom,
        )
      ],
    );
  }
}
