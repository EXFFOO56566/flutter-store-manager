// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import 'package:flutter_store_manager/pages/store_setting/bloc/store_setting_bloc.dart';

// View
import 'field/bank_account_name.dart';
import 'field/bank_account_number.dart';
import 'field/bank_iban.dart';
import 'field/bank_name.dart';
import 'field/bank_state.dart';
import 'field/bank_swift_code.dart';
import 'field/email_paypal.dart';
import 'field/ifsc_code.dart';
import 'field/routing_number.dart';
import 'package:flutter_store_manager/themes.dart';

class PaymentForm extends StatefulWidget {
  final String method;
  final StoreSettingState storeSettingState;
  final Function(String) changeMethod;
  final EdgeInsetsGeometry? padding;

  const PaymentForm({
    Key? key,
    required this.method,
    required this.storeSettingState,
    required this.changeMethod,
    this.padding,
  }) : super(key: key);

  @override
  PaymentFormState createState() => PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> {
  Widget buildMethod(ThemeData theme, TranslateType translate) {
    List<Option> methods = [
      Option(key: 'paypal', name: translate('common:text_paypal')),
      Option(key: 'bank_transfer', name: translate('common:text_bank_transfer')),
    ];

    return Row(
      children: [
        Expanded(
          child: Text(
            translate('account:text_payment_method'),
            style: theme.textTheme.caption,
          ),
        ),
        SizedBox(
          width: 156,
          child: InputDropdown(
            options: methods,
            value: widget.method,
            onChanged: widget.changeMethod,
            isOutline: false,
            isSmall: true,
          ),
        ),
      ],
    );
  }

  Widget buildTitle(ThemeData theme, TranslateType translate) {
    String text = '';
    switch (widget.method) {
      case 'bank_transfer':
        text = translate('account:text_detail_bank');
        break;
      default:
        text = translate('account:text_detail_paypal');
    }
    return Text(text, style: theme.textTheme.headline6);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMethod(theme, translate),
          const SizedBox(height: 30),
          buildTitle(theme, translate),
          if (widget.method == 'paypal') ...[
            const SizedBox(height: 15),
            PaymentPaypalEmailWidget(),
          ],
          if (widget.method == 'bank_transfer') ...[
            const SizedBox(height: 15),
            PaymentBankAcNameWidget(),
            const SizedBox(height: 15),
            PaymentBankAcNumWidget(),
            const SizedBox(height: 15),
            PaymentBankNameWidget(),
            const SizedBox(height: 15),
            PaymentBankStateWidget(key: const Key("PaymentBankStateWidget")),
            const SizedBox(height: 15),
            PaymentRoutingNumWidget(key: const Key("PaymentRoutingNumWidget")),
            const SizedBox(height: 15),
            PaymentIbanWidget(key: const Key("PaymentIbanWidget")),
            const SizedBox(height: 15),
            PaymentSwiftCodeWidget(),
            const SizedBox(height: 15),
            PaymentIfscCodeWidget(),
          ]
        ],
      ),
    );
  }
}
