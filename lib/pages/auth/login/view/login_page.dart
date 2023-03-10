import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/login_social/login_social.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

// Pages
import 'package:flutter_store_manager/pages/pages.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: LoginContainer(
          heading: LoginHeading(
            logo: Image.asset('assets/images/logo.png'),
            title: AppLocalizations.of(context)!.translate('auth:text_welcome'),
          ),
          form: const LoginForm(),
          footer: AuthFooter(
            subtitle: AppLocalizations.of(context)!.translate('auth:text_no_account'),
            buttonTitle: AppLocalizations.of(context)!.translate('auth:text_sign_up'),
            onPressedButton: () => Navigator.pushNamed(context, RegisterScreen.routeName),
          ),
          socials: const _LoginSocial(),
          subtitleLogin: AppLocalizations.of(context)!.translate('auth:text_login_social'),
        ),
      ),
    );
  }
}

class _LoginSocial extends StatelessWidget {
  const _LoginSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginSocial(
      type: 'login',
      onChangeStatus: (status) => context.read<LoginBloc>().add(LoginChangeStatus(status)),
    );
  }
}
