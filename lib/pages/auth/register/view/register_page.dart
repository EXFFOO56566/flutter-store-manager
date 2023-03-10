// Themes and UI
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../bloc/register_bloc.dart';

// Widget
import 'register_form.dart';

class RegisterScreen extends StatelessWidget with AppbarMixin {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('auth:text_register')),
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: RegisterContainer(
          key: const Key(routeName),
          form: const RegisterForm(),
          footer: AuthFooter(
            subtitle: AppLocalizations.of(context)!.translate('auth:text_have_account'),
            buttonTitle: AppLocalizations.of(context)!.translate('auth:text_sign_in'),
            onPressedButton: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
