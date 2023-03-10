import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/constants/auth.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../bloc/login_mobile_bloc.dart';

import 'login_mobile_firebase.dart';
import 'login_mobile_digits.dart';

class LoginMobileScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/login-mobile';

  const LoginMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    String type = data is String ? data : 'login';
    String method = loginNumberMethod;

    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('auth:text_login_mobile')),
      body: BlocProvider(
        create: (context) {
          return LoginMobileBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: method == 'firebase' ? LoginMobileFirebase(type: type) : LoginMobileDigits(type: type),
      ),
    );
  }
}
