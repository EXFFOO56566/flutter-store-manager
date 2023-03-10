import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/widget/field/bank_account_name.dart';
import 'package:example/screens/store_setup/widget/field/bank_account_number.dart';
import 'package:example/screens/store_setup/widget/field/bank_iban.dart';
import 'package:example/screens/store_setup/widget/field/bank_name.dart';
import 'package:example/screens/store_setup/widget/field/bank_state.dart';
import 'package:example/screens/store_setup/widget/field/bank_swift_code.dart';
import 'package:example/screens/store_setup/widget/field/email_paypal.dart';
import 'package:example/screens/store_setup/widget/field/routing_number.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

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
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  Widget buildMethod(ThemeData theme) {
    List<Option> methodList = const [
      Option(key: 'paypal', name: "Paypal"),
      Option(key: 'bank', name: "Bank Transfer"),
    ];

    return Row(
      children: [
        Expanded(
          child: Text(
            "Payment Method",
            style: theme.textTheme.caption,
          ),
        ),
        SizedBox(
          width: 156,
          child: InputDropdown(
            options: methodList,
            value: widget.method,
            onChanged: widget.changeMethod,
            isOutline: false,
            isSmall: true,
          ),
        ),
      ],
    );
  }

  Widget buildTitle(
    ThemeData theme,
  ) {
    String text = '';
    switch (widget.method) {
      case 'bank':
        text = "Bank Detail";
        break;
      default:
        text = "Paypal Detail";
    }
    return Text(text, style: theme.textTheme.headline6);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMethod(theme),
          const SizedBox(height: 30),
          buildTitle(theme),
          if (widget.method == 'paypal') ...[
            const SizedBox(height: 15),
            PaymentPaypalEmailWidget(),
          ],
          if (widget.method == 'bank') ...[
            const SizedBox(height: 15),
            PaymentBankAcNameWidget(),
            const SizedBox(height: 15),
            PaymentBankAcNumWidget(),
            const SizedBox(height: 15),
            PaymentBankNameWidget(),
            const SizedBox(height: 15),
            PaymentBankStateWidget(),
            const SizedBox(height: 15),
            PaymentRoutingNumWidget(),
            const SizedBox(height: 15),
            PaymentIbanWidget(),
            const SizedBox(height: 15),
            PaymentSwiftCodeWidget(),
          ]
        ],
      ),
    );
  }
}
