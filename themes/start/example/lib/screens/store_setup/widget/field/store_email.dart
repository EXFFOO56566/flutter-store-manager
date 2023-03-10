import 'package:example/screens/store_setup/model/store_email.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

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
          label: "Store Email",
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
                    ? "Invalid"
                    : "Invalid format"
                : null,
          ),
        );
      },
    );
  }
}
