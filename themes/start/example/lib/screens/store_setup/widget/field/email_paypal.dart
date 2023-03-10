import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class PaymentPaypalEmailWidget extends StatelessWidget {
  PaymentPaypalEmailWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.emailPaypal != current.emailPaypal,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.emailPaypal ?? "")
            ..selection = TextSelection.collapsed(offset: state.emailPaypal?.length ?? 0),
          label: "Email",
          onChanged: (String value) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(PaymentEmailPaypalChanged(value));
              }
            });
          },
        );
      },
    );
  }
}
