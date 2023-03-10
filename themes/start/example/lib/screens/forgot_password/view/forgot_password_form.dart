import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ui/ui.dart';

import '../bloc/forgot_password_bloc.dart';
import '../widgets/widgets.dart';

class ForgotPasswordForm extends StatelessWidget with SnackMixin {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? 'Forgot password fail');
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, 'Forgot password success');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your account email address and we\'ll send instructions on how to reset your password',
            style: theme.textTheme.caption,
          ),
          const SizedBox(height: 20),
          const InputEmail(),
          const SizedBox(height: 40),
          const SizedBox(
            width: double.infinity,
            child: ButtonSubmit(),
          ),
        ],
      ),
    );
  }
}
