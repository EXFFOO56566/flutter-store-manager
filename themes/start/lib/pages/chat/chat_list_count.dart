import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/widgets/badge.dart';

class ChatListCount extends StatelessWidget {
  final String count;
  const ChatListCount({Key? key, this.count = '0'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          CommunityMaterialIcons.email_outline,
          size: 22,
          color: theme.primaryColor,
        ),
        const SizedBox(width: 3),
        Badge(
          title: count,
          background: theme.primaryColor.withOpacity(0.1),
          color: theme.primaryColor,
          radius: 8,
          titleStyle: theme.textTheme.caption?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
