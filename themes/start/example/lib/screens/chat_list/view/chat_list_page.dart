import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  static const routeName = '/chat_list';
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Chat list'),
      ),
    );
  }
}
