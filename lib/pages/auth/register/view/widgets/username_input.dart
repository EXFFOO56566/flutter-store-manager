// Themes & UI
import 'package:flutter/material.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/register/bloc/register_bloc.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_username'),
          onChanged: (username) => context.read<RegisterBloc>().add(UsernameChanged(username)),
          decoration: InputDecoration(
            errorText:
                state.username.invalid ? AppLocalizations.of(context)!.translate('validate:text_username') : null,
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
