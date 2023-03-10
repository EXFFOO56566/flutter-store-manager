// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';

class NonVendor extends StatelessWidget {
  const NonVendor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.translate('common:text_non_vendor')),
              TextButton(
                  onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
                  child: Text(AppLocalizations.of(context)!.translate('account:text_title_logout'))),
            ],
          ),
        ),
      );
    });
  }
}
