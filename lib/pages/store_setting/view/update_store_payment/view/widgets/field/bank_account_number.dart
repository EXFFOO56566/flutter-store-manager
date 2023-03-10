// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class PaymentBankAcNumWidget extends StatelessWidget {
  PaymentBankAcNumWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.bankAccountNumber != current.bankAccountNumber,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.bankAccountNumber ?? "")
            ..selection = TextSelection.collapsed(offset: state.bankAccountNumber?.length ?? 0),
          label: translate('inputs:text_bank_number'),
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
