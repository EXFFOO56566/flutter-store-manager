import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

class ChatItem extends StatelessWidget with ChatMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const ChatItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = false;
    return ChatItemUi(
      avatar: buildImage(
        url:
            'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg',
        colorDot: const Color(0xFFFDC309),
        theme: theme,
        isLoading: loading,
      ),
      name: buildName(text: 'Erik Risson', theme: theme, isLoading: loading),
      time: buildTime(text: '9:05 AM', theme: theme, isLoading: loading),
      message: buildMessage(text: 'Sed ut perspiciatis unde omnis...', theme: theme, isLoading: loading),
      count: buildCount(text: '2', theme: theme),
      padding: padding,
      indentDivider: indentDivider ?? 80,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: () => Navigator.pushNamed(context, ChatDetailScreen.routeName),
    );
  }
}
