import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

import '../services/chat_service.dart';
import 'chat_text_item.dart';

class ChatConversation extends StatefulWidget {
  final Map<String, dynamic> args;
  final String avatar;

  const ChatConversation({Key? key, required this.args, required this.avatar}) : super(key: key);

  @override
  State<ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> with ChatService {
  List<Map<String, dynamic>> _messages = [];

  @override
  void didChangeDependencies() {
    String conversationId = widget.args['conversation_id'];

    subscribeChatMessages(
      conversationId: conversationId,
      onChanged: _onChangeMessages,
    );
    subscribeEndChat(conversationId: conversationId);
    subscribeTyping(conversationId: conversationId, onTyping: _onTyping);

    super.didChangeDependencies();
  }

  void _onChangeMessages(List<Map<String, dynamic>> messages) {
    if (mounted) {
      setState(() {
        _messages = messages;
      });
    }
  }

  void _onTyping(String type, String? name) {
    List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.of(_messages);

    if (name == widget.args['user_name']) {
      if (type == 'added') {
        messages.insert(0, {
          'type': 'custom',
          'id': widget.args['user_id'],
          'user_id': widget.args['user_id'],
          'firstName': widget.args['user_name'],
          'avatar': widget.args['avatar'],
        });
      }
    }

    if (type == 'deleted' && messages.isNotEmpty) {
      messages = messages.where((element) => element['type'] != 'custom').toList();
    }

    setState(() {
      _messages = messages;
    });
  }

  /// Handle user submit chat content
  void _handleChat(String txt) {
    if (txt.isNotEmpty) {
      Map<String, dynamic> message = {
        "avatar_image": widget.avatar,
        "avatar_type": "image",
        "conversation_id": widget.args['conversation_id'],
        "gravatar": '',
        "msg": txt,
        "msg_time": DateTime.now().millisecondsSinceEpoch,
        "read": false,
        "user_id": 'fbc-op-${widget.args['vendor_id']}',
        "vendor_id": widget.args['vendor_id'],
        "user_name": widget.args['vendor_name'],
        "type": "text",
        "user_type": "operator",
      };
      addChat(message);
    }
  }

  void onDisplay(Map message) {
    if (message['metadata'] != null && message['metadata']['user_type'] == "visitor") {
      readMessage(conversationId: message['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChatView(
      appBar: _buildAppbar(),
      messages: _buildMessages(),
    );
  }

  Widget _buildAppbar() {
    return ChatAppBar(avatar: widget.args['avatar'], title: widget.args['user_name'], status: widget.args['status']);
  }

  Widget _buildMessages() {
    return ChatMessages(
      data: _messages,
      userId: 'fbc-op-${widget.args['vendor_id']}',
      handleChat: _handleChat,
      textBuilder: ({required Map message, required int widthItem, TextStyle? style}) {
        return ChatTextItem(message: message, widthItem: widthItem, style: style, onDisplay: onDisplay);
      },
    );
  }
}
