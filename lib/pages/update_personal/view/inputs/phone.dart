import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class PersonalPhone extends StatelessWidget {
  final TextEditingController? phoneController;
  const PersonalPhone({Key? key, this.phoneController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => (previous.phone != current.phone),
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_phone'),
          controller: phoneController,
          onChanged: (value) {
            context.read<UpdatePersonalBloc>().add(PhoneChanged(value));
          },
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}
