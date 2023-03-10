import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StoreSetupPolicy extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupPolicy({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: '3. Policy setup',
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
            children: const [
              InputTextField(label: 'Policy Tab Label'),
              SizedBox(height: 15),
              InputTextField(
                label: 'Shipping Policy',
                minLines: 5,
              ),
              SizedBox(height: 15),
              InputTextField(
                label: 'Refund Policy',
                minLines: 5,
              ),
              SizedBox(height: 15),
              InputTextField(
                label: 'Cancellation/Return/Exchange Policy',
                minLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
