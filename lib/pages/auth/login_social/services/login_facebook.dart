import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

mixin FacebookLoginMixin<T extends StatefulWidget> on State<T> {
  Future loginFacebook(LoginSocialType login) async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        login({
          'type': 'facebook',
          'token': result.accessToken!.token,
        });
      } else {
        avoidPrint(result.status);
        avoidPrint(result.message);
      }
    } catch (e) {
      avoidPrint(e);
    }
  }
}
