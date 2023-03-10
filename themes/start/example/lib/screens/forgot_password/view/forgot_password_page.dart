import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../bloc/forgot_password_bloc.dart';

import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/forgot_password';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordBloc();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(title: 'Forgot Password'),
        body: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 32),
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
