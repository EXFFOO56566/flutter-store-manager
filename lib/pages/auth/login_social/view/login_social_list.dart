import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Pages
import 'package:flutter_store_manager/pages/pages.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

// Service
import '../bloc/login_social_bloc.dart';
import '../services/login_apple.dart';
import '../services/login_facebook.dart';
import '../services/login_google.dart';

class LoginSocialList extends StatefulWidget {
  final String type;
  const LoginSocialList({Key? key, this.type = 'login'}) : super(key: key);

  @override
  State<LoginSocialList> createState() => _LoginSocialListState();
}

class _LoginSocialListState extends State<LoginSocialList> with AppleLoginMixin, FacebookLoginMixin, GoogleLoginMixin {
  @override
  void initState() {
    subscribe(login);
    super.initState();
  }

  void login(Map<String, dynamic> data) {
    context.read<LoginSocialBloc>().add(LoginSocialSubmitted(data));
  }

  _handleLogin(String typeSocial) {
    switch (typeSocial) {
      case 'apple':
        loginApple(login);
        break;
      case 'facebook':
        loginFacebook(login);
        break;
      case 'google':
        loginGoogle();
        break;
      case 'sms':
        Navigator.pushNamed(context, LoginMobileScreen.routeName, arguments: widget.type);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthSocials(
      handleSocial: _handleLogin,
      isLoginApple: !kIsWeb && Platform.isIOS,
    );
  }
}
