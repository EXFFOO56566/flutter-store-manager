// Themes & UI
import 'dart:io';

import 'package:example/blocs/auth/auth_cubit.dart';
import 'package:example/constants/constants.dart';
import 'package:example/screens/store_setup/multi_step_setup/store_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:ui/mixins/mixins.dart';
import 'package:ui/pages/auth/auth_socials.dart';
import 'widgets/widgets.dart';

// Localization

// Form
import 'package:formz/formz.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';

class RegisterFormField extends StatelessWidget with SnackMixin {
  const RegisterFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? "Login Fail");
        }
        if (state.status.isSubmissionSuccess) {
          context.read<AuthCubit>().loginAuth(state.user);
          showSuccess(context, "Register Success");
          Navigator.pushNamed(context, StoreSetupScreen.routeName);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: FirstNameInput(),
              ),
              SizedBox(width: 12),
              Expanded(
                child: LastNameInput(),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const EmailInput(),
          const SizedBox(height: 15),
          const UsernameInput(),
          const SizedBox(height: 15),
          const PasswordInput(),
          const SizedBox(height: 40),
          const RegisterButton(),
          const SizedBox(height: 23),
          Text("or register with", style: theme.textTheme.caption),
          const SizedBox(height: 20),
          AuthSocials(
            isLoginApple: !isWeb && Platform.isIOS,
            handleSocial: (String type) {
              if (type == 'sms') {}
            },
          ),
        ],
      ),
    );
  }
}
