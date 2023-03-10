import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

import '../services/chat_count_service.dart';

class ChatCount extends StatefulWidget {
  final String vendorId;

  const ChatCount({Key? key, required this.vendorId}) : super(key: key);

  @override
  State<ChatCount> createState() => _ChatCountState();
}

class _ChatCountState extends State<ChatCount> with ChatCountService {
  int _count = 0;

  @override
  void didChangeDependencies() {
    subscribeChatCount(vendor: int.parse(widget.vendorId), onChange: onChanged);
    super.didChangeDependencies();
  }

  void onChanged(int count) {
    if (mounted) {
      setState(() {
        _count = count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChatListCount(count: '$_count');
  }
}
