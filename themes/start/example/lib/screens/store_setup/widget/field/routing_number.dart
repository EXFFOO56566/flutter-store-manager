import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class PaymentRoutingNumWidget extends StatelessWidget {
  PaymentRoutingNumWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.routingNum != current.routingNum,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.routingNum ?? "")
            ..selection = TextSelection.collapsed(offset: state.routingNum?.length ?? 0),
          label: "Routing Number",
          onChanged: (String value) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(PaymentBankRoutingNumChanged(value));
              }
            });
          },
        );
      },
    );
  }
}
