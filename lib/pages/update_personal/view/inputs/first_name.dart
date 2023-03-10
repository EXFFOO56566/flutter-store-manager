import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class PersonalFirstName extends StatelessWidget {
  final TextEditingController? firstNameController;
  const PersonalFirstName({Key? key, this.firstNameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => (previous.firstName != current.firstName),
      builder: (context, state) {
        return InputTextField(
          key: const Key("update_personal_first"),
          label: translate('inputs:text_first_name'),
          controller: firstNameController,
          onChanged: (value) {
            context.read<UpdatePersonalBloc>().add(FirstNameChanged(value));
          },
          decoration: InputDecoration(
            errorText: state.firstName.invalid ? translate('validate:text_at_least_2_characters') : null,
          ),
        );
      },
    );
  }
}
