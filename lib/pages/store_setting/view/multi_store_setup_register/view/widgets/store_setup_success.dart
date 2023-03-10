// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';

// View

import 'package:flutter_store_manager/pages/home/view/home_page.dart';
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSuccessPage extends StatelessWidget with AppbarMixin {
  const StoreSetupSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
      appBar: baseStyleAppBar(
        title: translate('auth:text_ready'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 38, 25, 25),
        child: StoreSetupSuccess(
          title: translate('auth:text_wel_wcfm'),
          subtitle: translate('auth:text_read_description_wcfm'),
          button: ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(SkipMultiStep());
              Navigator.pushNamed(context, HomePage.routeName);
            },
            child: Text(translate('common:text_go_dashboard')),
          ),
        ),
      ),
    );
  }
}
