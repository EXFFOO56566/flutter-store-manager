import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatMessages extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final void Function(String) handleChat;
  final Widget Function({required Map message, required int widthItem, TextStyle? style}) textBuilder;
  final String userId;

  const ChatMessages({
    Key? key,
    required this.data,
    required this.handleChat,
    required this.textBuilder,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode _focus;
  bool _showButtonSend = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _controller.addListener(() {
      if (_controller.text.isNotEmpty && !_showButtonSend) {
        setState(() {
          _showButtonSend = true;
        });
      }
      if (_controller.text.isEmpty && _showButtonSend) {
        setState(() {
          _showButtonSend = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focus.dispose();
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      // await OpenFile.open(message.uri);
    }
  }

  InputBorder getBorderInput({double width = 1, required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
      borderRadius: BorderRadius.circular(24),
    );
  }

  Widget customMessageBuilder(types.CustomMessage mess, {required int messageWidth}) {
    return SizedBox(
      width: 100,
      height: 50,
      // child: entryLoading(context),
      child: Center(
          child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColor,
        size: 14.0,
      )),
    );
  }

  types.Message convert(Map<String, dynamic> json) {
    if (json['type'] == 'custom') {
      return types.CustomMessage(
        id: json['id'],
        author: types.User(id: json['user_id'], imageUrl: json['avatar']),
      );
    }

    return types.Message.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ChatTheme chatTheme = DefaultChatTheme(
      backgroundColor: theme.scaffoldBackgroundColor,
      primaryColor: theme.primaryColor,
      secondaryColor: theme.colorScheme.surface,
      inputBackgroundColor: Colors.transparent,
      sentMessageCaptionTextStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.white),
      sentMessageBodyTextStyle: theme.textTheme.bodyText2!.copyWith(color: Colors.white),
      sentMessageLinkTitleTextStyle: theme.textTheme.subtitle1!.copyWith(color: Colors.white),
      sentMessageLinkDescriptionTextStyle: theme.textTheme.bodyText2!.copyWith(color: Colors.white),
      receivedMessageBodyTextStyle: theme.textTheme.bodyText2!.copyWith(color: theme.textTheme.subtitle1?.color),
      receivedMessageCaptionTextStyle: theme.textTheme.subtitle2!,
      receivedMessageLinkDescriptionTextStyle:
          theme.textTheme.bodyText2!.copyWith(color: theme.textTheme.subtitle1?.color),
      receivedMessageLinkTitleTextStyle: theme.textTheme.subtitle1!,
      dateDividerTextStyle: theme.textTheme.caption!,
      emptyChatPlaceholderTextStyle: theme.textTheme.caption!,
      inputContainerDecoration: const BoxDecoration(color: Colors.transparent),
      inputTextColor: theme.textTheme.subtitle1!.color!,
      inputTextStyle: theme.textTheme.bodyText2!,
      inputTextDecoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        filled: true,
        fillColor: theme.colorScheme.surface,
      ),
    );

    return Chat(
      customMessageBuilder: customMessageBuilder,
      messages: widget.data.map((json) => convert(json)).toList(),
      // onAttachmentPressed: _handleAtachmentPressed,
      onMessageTap: _handleMessageTap,
      textMessageBuilder: (
        types.TextMessage message, {
        required int messageWidth,
        required bool showName,
      }) {
        TextStyle style = message.author.id == widget.userId
            ? chatTheme.sentMessageBodyTextStyle
            : chatTheme.receivedMessageBodyTextStyle;
        return widget.textBuilder(message: message.toJson(), widthItem: messageWidth, style: style);
      },
      // onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: (types.PartialText txt) => widget.handleChat(txt.text),
      user: types.User(id: widget.userId),
      showUserAvatars: true,
      l10n: const ChatL10nEn(emptyChatPlaceholder: '...'),
      theme: chatTheme,
    );
  }
}
