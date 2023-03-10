import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class PersonalEmail extends StatelessWidget {
  final TextEditingController? emailController;
  const PersonalEmail({Key? key, this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => (previous.email != current.email),
      builder: (context, state) {
        return InputTextField(
          key: const Key("update_personal_email"),
          label: translate('inputs:text_email'),
          isRequired: true,
          controller: emailController,
          onChanged: (value) {
            context.read<UpdatePersonalBloc>().add(EmailChanged(value));
          },
          decoration: InputDecoration(
            errorText: state.email.invalid ? translate('validate:text_email') : null,
          ),
          keyboardType: TextInputType.emailAddress,
          enabled: false,
        );
      },
    );
  }
}
