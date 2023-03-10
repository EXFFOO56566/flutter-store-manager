import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class StorePhoneWidget extends StatelessWidget {
  StorePhoneWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      key: const Key("storePhone"),
      buildWhen: (previous, current) => previous.storePhone != current.storePhone,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.storePhone ?? "")
            ..selection = TextSelection.collapsed(offset: state.storePhone?.length ?? 0),
          key: const Key("storePhone"),
          label: "Store Phone",
          onChanged: (phone) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(StorePhoneChanged(phone));
              }
            });
          },
        );
      },
    );
  }
}
