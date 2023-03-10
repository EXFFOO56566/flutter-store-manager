import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class SupportEmailWidget extends StatelessWidget {
  SupportEmailWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.supportEmail != current.supportEmail,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Store Email",
          isRequired: true,
          controller: TextEditingController(text: state.supportEmail ?? ""),
          onChanged: (email) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(SupportEmailChanged(email));
              }
            });
          },
        );
      },
    );
  }
}
