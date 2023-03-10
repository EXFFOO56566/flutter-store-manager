import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/login_bloc.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (!state.status.isSubmissionInProgress) {
              context.read<LoginBloc>().add(const LoginSubmitted());
            }
          },
          style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          child: state.status.isSubmissionInProgress
              ? const CupertinoActivityIndicator(color: Colors.white)
              : const Text('Login'),
        );
      },
    );
  }
}
