import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/chats/chats.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import 'package:flutter_store_manager/themes.dart';

import '../services/chat_list_service.dart';
import 'chat_avatar_item.dart';

class ChatRecently extends StatefulWidget {
  final String vendor;

  const ChatRecently({Key? key, required this.vendor}) : super(key: key);

  @override
  State<ChatRecently> createState() => _ChatRecentlyState();
}

class _ChatRecentlyState extends State<ChatRecently> with ChatListService, ChatMixin {
  List<Map<String, dynamic>> _contacts = [];
  bool _loading = true;

  void onChange(value) {
    if (mounted) {
      setState(() {
        _loading = false;
        _contacts = value;
      });
    }
  }

  @override
  void didChangeDependencies() {
    subscribeChatList(vendor: widget.vendor, onChange: onChange);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        List<Map<String, dynamic>> dataContact = getSearchContact(data: _contacts, search: state.keyword ?? '');
        if (!_loading && dataContact.isEmpty) {
          return Container();
        }
        List<Map<String, dynamic>> emptyChats = List.generate(10, (index) => <String, dynamic>{}).toList();
        List<Map<String, dynamic>> data = _loading ? emptyChats : dataContact;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
              child: Text(translate('chat:text_recent'), style: theme.textTheme.subtitle2),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(data.length, (index) {
                  double padEnd = index < 9 ? 20 : 0;
                  Map<String, dynamic> item = data[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: padEnd),
                    child: ChatAvatarItem(item: item),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
