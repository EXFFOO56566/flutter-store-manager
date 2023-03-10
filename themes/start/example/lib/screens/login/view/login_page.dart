import 'dart:io';

import 'package:example/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ui/ui.dart';

import 'package:example/constants/constants.dart';
import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc();
      },
      child: Scaffold(
        body: LoginContainer(
          heading: LoginHeading(
            logo: Image.asset('assets/images/logo.png'),
          ),
          form: const LoginForm(),
          footer: AuthFooter(
            subtitle: 'Don\'t have an account ?',
            buttonTitle: 'Sign Up',
            onPressedButton: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
          ),
          socials: AuthSocials(
            isLoginApple: !isWeb && Platform.isIOS,
            handleSocial: (String type) {
              if (type == 'sms') {}
            },
          ),
        ),
      ),
    );
  }
}
