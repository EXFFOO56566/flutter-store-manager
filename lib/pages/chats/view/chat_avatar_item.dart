import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

class ChatAvatarItem extends StatelessWidget with ChatMixin {
  final Map<String, dynamic>? item;

  const ChatAvatarItem({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (item?.isEmpty == true) {
      return buildImage(
        theme: theme,
        isLoading: true,
      );
    }
    return buildImage(
      url: item?['avatar'] ?? '',
      colorDot: item?['status'] == 'online' ? const Color(0xFF2BBD69) : const Color(0xFFFDC309),
      theme: theme,
    );
  }
}
