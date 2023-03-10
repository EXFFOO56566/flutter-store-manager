import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../bloc/login_bloc.dart';

class InputName extends StatelessWidget {
  const InputName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputTextField(
          label: 'Username or Email address',
          decoration: InputDecoration(
            hintText: 'vendor',
            prefixIcon: Icon(
              CommunityMaterialIcons.account,
              size: 20,
              color: theme.textTheme.overline?.color,
            ),
            errorText: state.username.invalid ? 'Fill data' : null,
          ),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          initialValue: state.username.value,
        );
      },
    );
  }
}
