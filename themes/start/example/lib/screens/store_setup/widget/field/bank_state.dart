import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class PaymentBankStateWidget extends StatelessWidget {
  PaymentBankStateWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.bankState != current.bankState,
      builder: (context, state) {
        return InputTextField(
          controller: TextEditingController(text: state.bankState ?? "")
            ..selection = TextSelection.collapsed(offset: state.bankState?.length ?? 0),
          label: "State",
          onChanged: (String value) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(PaymentStateChanged(value));
              }
            });
          },
        );
      },
    );
  }
}
