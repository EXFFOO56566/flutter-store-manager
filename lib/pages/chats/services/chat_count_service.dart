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

mixin ChatCountService<T extends StatefulWidget> on State<T> {
  late StreamSubscription _subscribe;

  /// Subscribe chat item
  subscribeChatCount({
    required int vendor,
    required Function onChange,
  }) {
    Stream<DatabaseEvent> stream = chatMessagesRef.orderByChild('vendor_id').equalTo(vendor).onValue;
    _subscribe = stream.listen((DatabaseEvent event) {
      int count = 0;

      for (DataSnapshot item in event.snapshot.children) {
        Map data = item.value as Map;
        if (!data['read'] && '${data['vendor_id']}' == '$vendor' && data['user_type'] == 'visitor') {
          count++;
        }
      }
      onChange(count);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscribe.cancel();
  }
}
