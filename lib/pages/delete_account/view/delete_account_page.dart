import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';

import '../cubit/delete_account_cubit.dart';

import 'delete_account_body.dart';

class DeleteAccountPage extends StatelessWidget {
  static const String routeName = '/delete_account';

  const DeleteAccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider(
        create: (context) {
          return DeleteAccountCubit(
            authenticationRepository: AuthenticationRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
          );
        },
        child: const DeleteAccountBody(),
      ),
    );
  }
}
