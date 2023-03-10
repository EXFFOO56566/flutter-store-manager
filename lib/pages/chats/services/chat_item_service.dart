//
// Copyright 2022 Appcheap.io All rights reserved
//
// App Name:          Flutter Store Manager
// Source:            https://codecanyon.net/item/cirilla-multipurpose-flutter-wordpress-app/31940668
// Docs:              https://appcheap.io/docs/cirilla-developers-docs/
// Since:             1.0.0
// Author:            Appcheap.io
// Author URI:        https://appcheap.io

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference chatMessagesRef = database.ref("chat_messages");

mixin ChatItemService<T extends StatefulWidget> on State<T> {
  late StreamSubscription _subscribe;

  /// Subscribe chat item
  subscribeChatItem({
    required String conversationId,
    required int vendor,
    required Function onChange,
  }) {
    Stream<DatabaseEvent> stream = chatMessagesRef.orderByChild('conversation_id').equalTo(conversationId).onValue;

    _subscribe = stream.listen((DatabaseEvent event) {
      List<Map<String, dynamic>> messages = [];
      int count = 0;

      for (DataSnapshot item in event.snapshot.children) {
        Map data = item.value as Map;
        if (!data['read'] && '${data['vendor_id']}' == '$vendor' && data['user_type'] == 'visitor') {
          count++;
        }
        messages.add(
          {
            "msg_time": data['msg_time'],
            "msg": data['msg'],
          },
        );
      }
      if (messages.isNotEmpty) {
        messages.sort((a, b) => a['msg_time'].compareTo(b['msg_time']));
      }
      onChange(last: messages.isNotEmpty ? messages.last : null, count: count);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscribe.cancel();
  }
}
