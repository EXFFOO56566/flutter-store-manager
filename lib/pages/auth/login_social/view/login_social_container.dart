import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:formz/formz.dart';

// Bloc
import '../bloc/login_social_bloc.dart';
import 'login_social_list.dart';

class LoginSocial extends StatelessWidget {
  final String type;
  final void Function(FormzStatus status) onChangeStatus;

  const LoginSocial({
    Key? key,
    this.type = 'login',
    required this.onChangeStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginSocialBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          onChangeStatus: onChangeStatus,
        );
      },
      // child: const LoginForm(),
      child: LoginSocialList(type: type),
    );
  }
}
