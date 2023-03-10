import 'package:flutter/material.dart';

class ChatListContainer extends StatelessWidget {
  final String title;
  final Widget countChat;
  final Widget content;

  const ChatListContainer({
    Key? key,
    required this.title,
    required this.countChat,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title, style: theme.textTheme.headline6),
        actions: [
          countChat,
          const SizedBox(width: 25),
        ],
        centerTitle: false,
        titleSpacing: 25,
      ),
      backgroundColor: theme.dividerColor,
      body: content,
    );
  }
}
