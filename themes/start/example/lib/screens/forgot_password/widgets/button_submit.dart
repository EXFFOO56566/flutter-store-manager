import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/forgot_password_bloc.dart';

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (!state.status.isSubmissionInProgress) {
              context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitted());
            }
          },
          style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          child: state.status.isSubmissionInProgress
              ? const CupertinoActivityIndicator(color: Colors.white)
              : const Text('Submit'),
        );
      },
    );
  }
}
