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
DatabaseReference chatUsersRef = database.ref('chat_users');

mixin ChatListService<T extends StatefulWidget> on State<T> {
  late StreamSubscription _subscribe;

  /// Subscribe chat messages
  subscribeChatList({
    required String vendor,
    required Function onChange,
  }) {
    Stream<DatabaseEvent> stream = chatUsersRef.orderByChild('vendor_id').equalTo(int.parse(vendor)).onValue;

    _subscribe = stream.listen((DatabaseEvent event) {
      List<Map<String, dynamic>> messages = [];

      for (DataSnapshot item in event.snapshot.children) {
        Map data = item.value as Map;
        messages.add(
          {
            'id': item.key,
            'conversation_id': data['conversation_id'],
            'current_page': data['current_page'],
            'is_mobile': data['is_mobile'],
            'last_online': data['last_online'],
            'status': data['status'],
            'user_email': data['user_email'],
            'user_id': data['user_id'],
            'user_ip': data['user_ip'],
            'user_name': data['user_name'],
            'user_type': data['user_type'],
            'vendor_id': data['vendor_id'],
            'vendor_name': data['vendor_name'],
            'avatar_type': data['avatar_type'],
            'gravatar': data['gravatar'],
            'avatar_image': data['avatar_image'],
            'avatar': data['avatar_type'] == 'image'
                ? data['avatar_image']
                : 'https://s.gravatar.com/avatar/${data['gravatar']}?s=80',
          },
        );
      }
      onChange(messages.where((o) => o['user_id'] != 'fbc-op-$vendor').toList());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscribe.cancel();
  }
}
