import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/chats/services/chat_item_service.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:intl/intl.dart';

import 'chat_avatar_item.dart';

class ChatItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final GestureTapCallback? onTap;

  const ChatItem({
    Key? key,
    required this.item,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    this.onTap,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> with ChatMixin, ChatItemService {
  int _count = 0;
  Map<String, dynamic> _last = {};

  void onChange({required int count, Map<String, dynamic>? last}) {
    if (mounted) {
      setState(() {
        _count = count;
        _last = last ?? {};
      });
    }
  }

  @override
  void didChangeDependencies() {
    subscribeChatItem(
      conversationId: widget.item['conversation_id'],
      vendor: widget.item['vendor_id'],
      onChange: onChange,
    );
    super.didChangeDependencies();
  }

  String _buildDate(dynamic date) {
    if (date != null) {
      DateTime newDate = DateTime.fromMicrosecondsSinceEpoch(date * 1000);
      return DateFormat('MMMM dd, y hh:mma', 'en_US').format(newDate);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = false;
    return ChatItemUi(
      avatar: ChatAvatarItem(item: widget.item),
      name: buildName(text: widget.item['user_name'], theme: theme, isLoading: loading),
      time: buildTime(text: _buildDate(_last['msg_time']), theme: theme, isLoading: loading),
      message: buildMessage(text: _last['msg'], theme: theme, isLoading: loading),
      count: buildCount(text: '$_count', theme: theme),
      padding: widget.padding,
      indentDivider: widget.indentDivider ?? 80,
      endIndentDivider: widget.endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: widget.onTap,
    );
  }
}

class ChatItemLoading extends StatelessWidget with ChatMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const ChatItemLoading({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = true;
    return ChatItemUi(
      avatar: buildImage(theme: theme, isLoading: true),
      name: buildName(text: '', theme: theme, isLoading: loading),
      time: buildTime(text: '', theme: theme, isLoading: loading),
      message: buildMessage(text: '', theme: theme, isLoading: loading),
      count: buildCount(theme: theme, isLoading: loading),
      padding: padding,
      indentDivider: indentDivider ?? 80,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
    );
  }
}
