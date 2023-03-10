import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../widgets/chat_item.dart';
import 'widgets/chat_list_recent.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = '/chat_list';

  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatListContainer(
      title: 'All Chats',
      countChat: const ChatListCount(),
      content: ChatListContent(
        searchWidget: const Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: InputSearchField(
            hintText: 'Enter Celebrity Name',
          ),
        ),
        recentWidget: const ChatListRecent(),
        viewWidget: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              12,
              (index) => const ChatItem(
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 25),
                indentDivider: 105,
                endIndentDivider: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
