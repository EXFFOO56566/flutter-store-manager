import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ui/ui.dart';

import 'package:example/blocs/blocs.dart';
import 'package:example/screens/screens.dart';

import '../bloc/login_bloc.dart';
import '../widgets/widgets.dart';

class LoginForm extends StatelessWidget with SnackMixin {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? 'Login fail');
        }
        if (state.status.isSubmissionSuccess) {
          context.read<AuthCubit>().loginAuth(state.user);
          showSuccess(context, 'Login success');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const InputName(),
          const SizedBox(height: 15),
          const InputPassword(),
          const SizedBox(height: 5),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, ForgotPasswordPage.routeName),
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.overline,
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(width: 120, child: ButtonLogin()),
        ],
      ),
    );
  }
}
