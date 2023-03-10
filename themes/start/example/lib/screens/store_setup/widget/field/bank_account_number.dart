import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class PaymentBankAcNumWidget extends StatelessWidget {
  PaymentBankAcNumWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.bankAccountNumber != current.bankAccountNumber,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.bankAccountNumber ?? "")
            ..selection = TextSelection.collapsed(offset: state.bankAccountNumber?.length ?? 0),
          label: "Bank Number",
          onChanged: (String value) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(PaymentBankAcNumChanged(value));
              }
            });
          },
        );
      },
    );
  }
}
