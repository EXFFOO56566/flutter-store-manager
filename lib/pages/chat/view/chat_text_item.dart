import 'package:flutter/material.dart';

class ChatTextItem extends StatefulWidget {
  final Map message;
  final int widthItem;
  final TextStyle? style;
  final void Function(Map message)? onDisplay;

  const ChatTextItem({
    Key? key,
    required this.widthItem,
    required this.message,
    this.style,
    this.onDisplay,
  }) : super(key: key);

  @override
  ChatTextItemState createState() => ChatTextItemState();
}

class ChatTextItemState extends State<ChatTextItem> {
  @override
  void didChangeDependencies() {
    if (widget.onDisplay != null) {
      widget.onDisplay!(widget.message);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.message['text'] ?? '';
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.widthItem.toDouble(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(text, style: widget.style),
      ),
    );
  }
}
