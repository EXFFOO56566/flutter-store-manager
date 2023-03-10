// Themes & UI
import 'package:ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/register/bloc/register_bloc.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputTextField(
          label: "Username",
          onChanged: (username) => context.read<RegisterBloc>().add(UsernameChanged(username)),
          decoration: InputDecoration(
            errorText: state.username.invalid ? "Invalid" : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.account,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
          ),
        );
      },
    );
  }
}
