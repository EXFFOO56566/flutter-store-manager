// Themes and UI
import 'package:example/screens/register/view/register_form.dart';
import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/containers/register_container.dart';

import 'package:ui/mixins/appbar_mixin.dart';
import 'package:ui/pages/auth/auth_footer.dart';
import '../bloc/register_bloc.dart';

// Widget

class RegisterPage extends StatelessWidget with AppbarMixin {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: "Vendor Registration"),
      body: BlocProvider(
        create: (context) {
          return RegisterBloc();
        },
        child: RegisterContainer(
          key: const Key(routeName),
          form: const RegisterFormField(),
          footer: AuthFooter(
            subtitle: "Already have an account?",
            buttonTitle: "Sign in",
            onPressedButton: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
