import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<Option> _methods = const [
  Option(key: 'paypal', name: 'Paypal'),
  Option(key: 'bank', name: 'Bank Transfer'),
];

class PaymentForm extends StatefulWidget {
  final String method;
  final Map<String, dynamic> data;
  final Function(String) changeMethod;
  final Function(String key, String value) changeData;
  final EdgeInsetsGeometry? padding;

  const PaymentForm({
    Key? key,
    required this.method,
    required this.data,
    required this.changeMethod,
    required this.changeData,
    this.padding,
  }) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  Widget buildMethod(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Payment Method',
            style: theme.textTheme.caption,
          ),
        ),
        SizedBox(
          width: 156,
          child: InputDropdown(
            options: _methods,
            value: widget.method,
            onChanged: widget.changeMethod,
            isOutline: false,
            isSmall: true,
          ),
        ),
      ],
    );
  }

  Widget buildTitle(ThemeData theme) {
    String text = '';
    switch (widget.method) {
      case 'bank':
        text = 'Detail Bank';
        break;
      default:
        text = 'Detail Paypal';
    }
    return Text(text, style: theme.textTheme.headline6);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String initEmail = widget.data['email'] ?? '';
    String initAccountName = widget.data['accountName'] ?? '';
    String initAccountNumber = widget.data['accountNumber'] ?? '';
    String initBankName = widget.data['bankName'] ?? '';
    String initState = widget.data['state'] ?? '';
    String initRoutingNumber = widget.data['routingNumber'] ?? '';
    String initIban = widget.data['iban'] ?? '';
    String initSwiftCode = widget.data['swiftCode'] ?? '';

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
            const LabelInput(title: 'Email'),
            TextFormField(
              initialValue: initEmail,
              onChanged: (String value) => widget.changeData('email', value),
            ),
          ],
          if (widget.method == 'bank') ...[
            const SizedBox(height: 15),
            const LabelInput(title: 'Bank Account Name'),
            TextFormField(
              initialValue: initAccountName,
              onChanged: (String value) => widget.changeData('accountName', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'Bank Account Number'),
            TextFormField(
              initialValue: initAccountNumber,
              onChanged: (String value) => widget.changeData('accountNumber', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'Name Of Bank'),
            TextFormField(
              initialValue: initBankName,
              onChanged: (String value) => widget.changeData('bankName', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'State'),
            TextFormField(
              initialValue: initState,
              onChanged: (String value) => widget.changeData('state', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'Routing Number'),
            TextFormField(
              initialValue: initRoutingNumber,
              onChanged: (String value) => widget.changeData('routingNumber', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'IBAN'),
            TextFormField(
              initialValue: initIban,
              onChanged: (String value) => widget.changeData('iban', value),
            ),
            const SizedBox(height: 15),
            const LabelInput(title: 'Swift Code'),
            TextFormField(
              initialValue: initSwiftCode,
              onChanged: (String value) => widget.changeData('swiftCode', value),
            ),
          ]
        ],
      ),
    );
  }
}
