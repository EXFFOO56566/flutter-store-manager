// Themes & UI
import 'package:example/utils/debug.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';

// Localization

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/register/bloc/register_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: 150,
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (!state.status.isSubmissionInProgress) {
                context.read<RegisterBloc>().add(const RegisterSubmitted());
              } else {
                avoidPrint('Can not click when isSubmissionInProgress');
              }
            },
            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
            child: state.status.isSubmissionInProgress
                ? const CupertinoActivityIndicator(color: Colors.white)
                : const Text("Register"),
          ),
        );
      },
    );
  }
}
