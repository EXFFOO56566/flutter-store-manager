import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class PersonalLastName extends StatelessWidget {
  final TextEditingController? lastNameController;
  const PersonalLastName({Key? key, this.lastNameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => (previous.lastName != current.lastName),
      builder: (context, state) {
        return InputTextField(
          key: const Key("update_personal_last"),
          label: translate('inputs:text_last_name'),
          controller: lastNameController,
          onChanged: (value) {
            context.read<UpdatePersonalBloc>().add(LastNameChanged(value));
          },
          decoration: InputDecoration(
            errorText: state.lastName.invalid ? translate('validate:text_at_least_2_characters') : null,
          ),
        );
      },
    );
  }
}
