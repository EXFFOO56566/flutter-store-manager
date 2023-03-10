import 'package:flutter/material.dart';
import 'package:ui/widgets/cache_image.dart';

class ChatAppBar extends StatelessWidget {
  final String? avatar;
  final String? title;
  final String? status;
  const ChatAppBar({Key? key, this.avatar, this.title, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: CacheImageView(
              image: avatar ?? '',
              width: 58,
              height: 58,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '', style: theme.textTheme.subtitle1),
              const SizedBox(height: 4),
              Text(status ?? '', style: theme.textTheme.caption),
            ],
          ),
        ),
      ],
    );
  }
}
