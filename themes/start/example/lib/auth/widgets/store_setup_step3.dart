import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class StoreSetupStep3 extends StatelessWidget {
  const StoreSetupStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: StoreSetupSuccess(
        title: 'Welcome',
        subtitle:
            'You have successfully submitted your Vendor Account request.\nYour Vendor application is still under review. You will receive details about our decision in your email very soon!',
        button: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
          child: const Text('Go To Dashboard'),
        ),
      ),
    );
  }
}
