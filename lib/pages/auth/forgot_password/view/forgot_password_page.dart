import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';
import '../bloc/forgot_password_bloc.dart';
import 'forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/forgot_password';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: AppLocalizations.of(context)!.translate('auth:text_forgot_password'),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 32),
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
