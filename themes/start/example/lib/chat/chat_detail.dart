import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'data.dart';

class ChatDetailScreen extends StatelessWidget with ChatMixin {
  static const routeName = '/chat-detail';

  const ChatDetailScreen({Key? key}) : super(key: key);

  /// Handle user submit chat content
  void _handleChat(String txt) {}

  @override
  Widget build(BuildContext context) {
    return ChatView(
      appBar: const ChatAppBar(
        avatar:
            'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg',
        title: 'Erik Risson',
        status: 'Online now',
      ),
      messages: ChatMessages(
        data: messages,
        userId: '06c33e8b-e835-4736-80f4-63f44b66666c',
        handleChat: _handleChat,
        textBuilder: ({required Map message, required int widthItem, TextStyle? style}) {
          return const Text('a');
        },
      ),
    );
  }
}
