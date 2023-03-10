// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';

// View
import 'package:flutter_store_manager/themes.dart';

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
    context.read<AddressCubit>().init();
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
      body: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: translate('auth:text_not_now'),
          textButtonPrimary: translate('auth:text_let_go'),
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
                Text(translate("auth:text_welcome_to_store"), style: theme.textTheme.headline6),
                const SizedBox(height: 25),
                Text(
                  translate('auth:text_setup_main_thank'),
                  style: theme.textTheme.caption,
                ),
                const SizedBox(height: 16),
                Text(
                  translate('auth:text_setup_main_if'),
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
