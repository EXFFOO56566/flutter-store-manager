import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

String _userToken = "";
String _userId = "";
void setUserToken({required String token}) {
  _userToken = token;
}

String get userToken => _userToken;
void setUserId({required String id}) {
  _userId = id;
}

String get userId => _userId;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Init Firebase service
Future<void> initializePushNotification() async {
  await Firebase.initializeApp();

  if (!kIsWeb) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

/// Update token to database
Future<void> updateTokenToDatabase(AsyncCallback updateUserToken) async {
  try {
    await updateUserToken();
  } catch (e) {
    avoidPrint(
        '=========> Warning: Plugin Push Notifications Mobile And Web App Not Installed. Download here: https://wordpress.org/plugins/push-notification-mobile-and-web-app');
  }
}

/// Remove user token database
Future<void> removeTokenInDatabase(VoidCallback removeToken) async {
  try {
    removeToken();
  } catch (_) {
    avoidPrint("Error from firebase message repository");
  }
}

/// Get token
Future<String?> getToken() async {
  return await FirebaseMessaging.instance.getToken();
}

/// Listening the changes
mixin MessagingMixin<T extends StatefulWidget> on State<T> {
  Future<void> subscribe(AsyncCallback updateToken, {Function? navigate}) async {
    if (kIsWeb || Platform.isIOS || Platform.isMacOS) {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized &&
          settings.authorizationStatus != AuthorizationStatus.provisional) {
        return;
      }
    }

    /// Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      updateTokenToDatabase(updateToken);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message?.data != null) {
        try {
          Map<String, dynamic> data = {
            'type': message!.data['type'],
            'route': message.data['route'],
            'args': jsonDecode(message.data['args'])
          };
          if (navigate != null) {
            navigate(data);
          }
        } catch (e) {
          avoidPrint(e);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message?.data != null) {
        try {
          Map<String, dynamic> data = {
            'type': message!.data['type'],
            'route': message.data['route'],
            'args': jsonDecode(message.data['args'])
          };
          if (navigate != null) {
            navigate(data);
          }
        } catch (e) {
          avoidPrint(e);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    // Timer(const Duration(seconds: 5), () async {
    //   // Get the token each time the application loads
    //   String? token = await getToken();
    //   avoidPrint("Token: $token");
    //
    //   // Save the initial token to the database
    //   await updateTokenToDatabase(updateToken);
    // });
  }
}
