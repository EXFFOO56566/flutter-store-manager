import 'package:flutter/material.dart';

class ReviewDetailContent extends StatelessWidget {
  final Widget avatar;
  final Widget name;
  final Widget dateTime;
  final Widget rating;
  final Widget description;

  const ReviewDetailContent({
    Key? key,
    required this.avatar,
    required this.name,
    required this.dateTime,
    required this.rating,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: avatar,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: name),
                      const SizedBox(width: 12),
                      rating,
                    ],
                  ),
                  const SizedBox(height: 7),
                  dateTime,
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        description,
      ],
    );
  }
}
