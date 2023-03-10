// Themes & UI
import 'package:ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/register/bloc/register_bloc.dart';

class LastNameInput extends StatelessWidget {
  const LastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return InputTextField(
          label: "Last Name",
          onChanged: (value) => context.read<RegisterBloc>().add(LastNameChanged(value)),
          decoration: InputDecoration(
            errorText: state.lastName.invalid ? "Invalid" : null,
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
