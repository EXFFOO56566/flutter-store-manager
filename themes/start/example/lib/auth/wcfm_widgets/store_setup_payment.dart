import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/payment_form.dart';

class StoreSetupPayment extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupPayment({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: '2. Payment setup',
        automaticallyImplyLeading: false,
      ),
      body: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: 'Skip this step',
          textButtonPrimary: 'Continue',
          onPressedSecondary: () => onNextStep(),
          onPressedPrimary: () => onNextStep(),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentForm(
                method: 'paypal',
                data: const {},
                changeData: (String key, String value) => {},
                changeMethod: (String value) => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
