import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StoreSetupMain extends StatelessWidget {
  final VoidCallback onGoStoreSetup;
  final VoidCallback onGoDashboard;

  const StoreSetupMain({
    Key? key,
    required this.onGoDashboard,
    required this.onGoStoreSetup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: 'Not right now',
          textButtonPrimary: 'Let\'s go!',
          onPressedSecondary: onGoDashboard,
          onPressedPrimary: onGoStoreSetup,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to Store Manager', style: theme.textTheme.headline6),
                const SizedBox(height: 25),
                Text(
                  'Thank you for choosing Store Manager! This quick setup wizard will help you ti configure the basic settings and you will have your store ready in no time.',
                  style: theme.textTheme.caption,
                ),
                const SizedBox(height: 16),
                Text(
                  'If you don\'t want to go through the wizard right now, you can skip and return to the dashboard. You may setup your store from dashboard > setting anytime!',
                  style: theme.textTheme.caption,
                ),
              ],
            ),
          ),
        ),
        // paddingBottom: Edge,
      ),
    );
  }
}
