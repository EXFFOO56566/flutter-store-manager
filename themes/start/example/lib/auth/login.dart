import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContainer(
        heading: LoginHeading(
          logo: Image.asset('assets/images/logo.png'),
        ),
        form: const LoginForm(),
        footer: AuthFooter(
          subtitle: 'Don\'t have an account ?',
          buttonTitle: 'Sign Up',
          onPressedButton: () => Navigator.pushNamed(context, RegisterWcfmScreen.routeName),
        ),
        socials: AuthSocials(
          handleSocial: (String type) {
            if (type == 'sms') {
              Navigator.pushNamed(context, LoginMobileScreen.routeName);
            }
          },
        ),
      ),
    );
  }
}
