// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class StoreEmailWidget extends StatelessWidget {
  StoreEmailWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storeEmail != current.storeEmail,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.storeEmail.value)
            ..selection = TextSelection.collapsed(offset: state.storeEmail.value.length),
          label: AppLocalizations.of(context)!.translate('inputs:text_store_email'),
          isRequired: true,
          onChanged: (email) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(StoreEmailChanged(email));
              }
            });
          },
          decoration: InputDecoration(
            errorText: state.storeEmail.invalid
                ? (state.storeEmail.error == StoreEmailValidationError.empty)
                    ? AppLocalizations.of(context)!.translate('validate:text_title')
                    : "Invalid format"
                : null,
          ),
        );
      },
    );
  }
}
