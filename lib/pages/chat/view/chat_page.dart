import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'chat_conversation.dart';

class ChatDetailScreen extends StatefulWidget {
  static const routeName = '/chat';

  final Map<String, dynamic> args;

  const ChatDetailScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      return ChatConversation(args: widget.args, avatar: state.user.avatar);
    });
  }
}
