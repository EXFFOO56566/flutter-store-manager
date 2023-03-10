// Themes & UI
import 'package:ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/register/bloc/register_bloc.dart';

class FirstNameInput extends StatelessWidget {
  const FirstNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return InputTextField(
          label: "First Name",
          onChanged: (value) => context.read<RegisterBloc>().add(FirstNameChanged(value)),
          decoration: InputDecoration(
            errorText: state.firstName.invalid ? "Invalid" : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.label,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
          ),
        );
      },
    );
  }
}
