import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';
import '../bloc/update_password_bloc.dart';
import '../widgets/update_password_body.dart';

class UpdatePasswordScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/update_password';

  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('account:text_change_password')),
      body: BlocProvider(
        create: (_) {
          return UpdatePasswordBloc(
            authenticationRepository: AuthenticationRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
          );
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const UpdatePasswordBody(),
        ),
      ),
    );
  }
}
