import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class SupportPhoneWidget extends StatelessWidget {
  SupportPhoneWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.supportPhone != current.supportPhone,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Store Phone",
          controller: TextEditingController(text: state.supportPhone ?? ""),
          onChanged: (phone) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(SupportPhoneChanged(phone));
              }
            });
          },
        );
      },
    );
  }
}
