import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/constants/credentials.dart';
import 'package:flutter_store_manager/types/types.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: kIsWeb || Platform.isAndroid ? googleClientId : null,
  scopes: <String>[
    'email',
    'profile',
  ],
);

mixin GoogleLoginMixin<T extends StatefulWidget> on State<T> {
  void subscribe(LoginSocialType login) {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        _handleLogin(account, login);
      }
    });
    _googleSignIn.signInSilently();
  }

  void _handleLogin(GoogleSignInAccount user, LoginSocialType login) async {
    GoogleSignInAuthentication auth = await user.authentication;
    login({'type': 'google', 'idToken': auth.idToken, 'callback': _logout});
  }

  void _logout() async {
    await _googleSignIn.signOut();
  }

  void loginGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      avoidPrint('---- Login Google Error---');
      avoidPrint(e);
      avoidPrint('---- End Login Google Error---');
    }
  }
}
