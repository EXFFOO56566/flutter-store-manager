import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class StoreNameWidget extends StatelessWidget {
  StoreNameWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storeName != current.storeName,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Store Name",
          isRequired: true,
          controller: TextEditingController(text: state.storeName.value)
            ..selection = TextSelection.collapsed(offset: state.storeName.value.length),
          onChanged: (name) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(StoreNameChanged(name));
              }
            });
          },
          decoration: InputDecoration(
            errorText: state.storeName.invalid ? "Invalid" : null,
          ),
        );
      },
    );
  }
}
