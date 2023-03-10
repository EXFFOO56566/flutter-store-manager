import 'package:flutter/material.dart';

import 'box_divider_ui.dart';

class ReviewItemUi extends StatelessWidget {
  final Widget avatar;
  final Widget name;
  final Widget status;
  final Widget dateTime;
  final Widget description;
  final Widget rating;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const ReviewItemUi({
    Key? key,
    required this.avatar,
    required this.name,
    required this.status,
    required this.dateTime,
    required this.description,
    required this.rating,
    this.dividerColor,
    this.indentDivider,
    this.endIndentDivider,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: BoxDividerUi(
        padding: padding,
        color: dividerColor,
        indentDivider: indentDivider,
        endIndentDivider: endIndentDivider,
        heightDivider: 1,
        child: Row(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [name],
                        ),
                      ),
                      const SizedBox(width: 12),
                      rating,
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [dateTime],
                        ),
                      ),
                      const SizedBox(width: 12),
                      status,
                    ],
                  ),
                  const SizedBox(height: 7),
                  description,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
