import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/chat/chat.dart';
import 'package:flutter_store_manager/pages/chats/chats.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../services/chat_list_service.dart';
import 'chat_item.dart';

class ChatList extends StatefulWidget {
  final String vendor;

  const ChatList({Key? key, required this.vendor}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with ChatListService, ChatMixin {
  List<Map<String, dynamic>> _contacts = [];
  bool loading = true;

  void onChange(value) {
    if (mounted) {
      setState(() {
        loading = false;
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
    if (loading) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            10,
            (index) => const ChatItemLoading(
              padding: EdgeInsets.symmetric(vertical: 19, horizontal: 25),
              indentDivider: 105,
              endIndentDivider: 25,
            ),
          ),
        ),
      );
    }

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        List<Map<String, dynamic>> dataContact = getSearchContact(data: _contacts, search: state.keyword ?? '');

        if (!loading && dataContact.isEmpty) {
          return NotificationEmptyView(
            icon: CommunityMaterialIcons.wechat,
            title: AppLocalizations.of(context)!.translate('chat:text_no_data'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              dataContact.length,
              (index) => ChatItem(
                key: Key(dataContact[index]['id']),
                item: dataContact[index],
                padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 25),
                indentDivider: 105,
                endIndentDivider: 25,
                onTap: () => Navigator.of(context).pushNamed(ChatDetailScreen.routeName, arguments: dataContact[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
