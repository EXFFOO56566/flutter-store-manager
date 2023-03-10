import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Vendor Registration'),
      body: RegisterContainer(
        form: const RegisterForm(),
        footer: AuthFooter(
          subtitle: 'Already have an account ?',
          buttonTitle: 'Sign In',
          onPressedButton: () => Navigator.pushNamed(context, LoginScreen.routeName),
        ),
      ),
    );
  }
}
