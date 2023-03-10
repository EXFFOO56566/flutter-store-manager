import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_store_manager/pages/chats/chats.dart';
import 'package:flutter_store_manager/pages/chats/view/chat_list.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_store_manager/themes.dart';

import 'chat_count.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = '/chats';

  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      return BlocProvider(
        create: (context) {
          return ChatCubit();
        },
        child: _ChatListView(userId: state.user.id),
      );
    });
  }
}

class _ChatListView extends StatefulWidget {
  final String userId;

  const _ChatListView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<_ChatListView> {
  late ChatCubit cubit;
  var keywordStream = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChatCubit>();
    cubit.changeKeyword(keyword: '');
    keywordStream.debounceTime(const Duration(milliseconds: 700)).listen((keyword) {
      cubit.changeKeyword(keyword: keyword);
    });
  }

  @override
  void dispose() {
    super.dispose();
    keywordStream.close();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return ChatListContainer(
      title: translate('chat:text_chat'),
      countChat: ChatCount(vendorId: widget.userId),
      content: ChatListContent(
        searchWidget: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: InputSearchField(
            hintText: translate('chat:text_search'),
            onChanged: (value) {
              keywordStream.add(value);
            },
          ),
        ),
        recentWidget: ChatRecently(vendor: widget.userId),
        viewWidget: ChatList(vendor: widget.userId),
      ),
    );
  }
}
