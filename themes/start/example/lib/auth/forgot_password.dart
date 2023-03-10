import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/forgot_password';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: 'Forgot Password',
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 32),
        child: ForgotPasswordForm(),
      ),
    );
  }
}
