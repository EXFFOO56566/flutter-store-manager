// Themes & UI
import 'package:flutter/material.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/register/bloc/register_bloc.dart';

class LastNameInput extends StatelessWidget {
  const LastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_last_name'),
          onChanged: (value) => context.read<RegisterBloc>().add(LastNameChanged(value)),
          decoration: InputDecoration(
            errorText:
                state.lastName.invalid ? AppLocalizations.of(context)!.translate('validate:text_last_name') : null,
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
