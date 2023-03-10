import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../bloc/forgot_password_bloc.dart';
import '../model/email.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({Key? key}) : super(key: key);

  String? getError(Email email) {
    if (email.invalid) {
      if (email.error == EmailValidationError.noEmail) {
        return 'No email';
      }
      return 'Fill data';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputTextField(
          label: 'Email Address',
          decoration: InputDecoration(
            prefixIcon: Icon(
              CommunityMaterialIcons.email,
              size: 20,
              color: theme.textTheme.overline?.color,
            ),
            errorText: getError(state.email),
          ),
          onChanged: (email) => context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          initialValue: state.email.value,
        );
      },
    );
  }
}
